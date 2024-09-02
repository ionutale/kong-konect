package main

import (
	"database/sql"
	"fmt"
	"log"
	"strings"

	"github.com/google/uuid"
	_ "github.com/lib/pq"
)

type myUUID uuid.UUID

type GenericResponse struct {
	Total int
	Data  interface{}
}

type Organization struct {
	ID          string    `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
	CreatedAt   string `json:"created_at"`
}

type Service struct {
	ID             string `json:"id"`
	OrganizationID string `json:"organization_id"`
	Name           string `json:"name"`
	Description    string `json:"description"`
	CreatedAt      string `json:"created_at"`
	UpdateAt       string `json:"update_at"`
	VersionsCount  int    `json:"versionsCount"`
}

type Versions struct {
	ID          string    `json:"id"`
	ServiceID   string    `json:"service_id"`
	Version     string `json:"version"`
	Name        string `json:"name"`
	Description string `json:"description"`
	CreatedAt   string `json:"created_at"`
}

var db = dbConnect()

func dbConnect() *sql.DB {
	connStr := "user=kong password=kong dbname=kong sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Println("Error connecting to the database: ", err)
	}

	return db
}


func fetchOrganizations() []Organization {
	rows, err := db.Query("SELECT name FROM organizations")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var organizations []Organization

	for rows.Next() {
		var organization Organization
		if err := rows.Scan(&organization.Name); err != nil {
			log.Fatal(err)
		}
		organizations = append(organizations, organization)
	}

	fmt.Println(organizations)
	return organizations
}

/**
 * Fetch services
 */
func fetchServices(page int, size int, search string, sort string) GenericResponse {

	// check if sort starts with - or + and remove it
	if strings.HasPrefix(sort, "-") {
		sort = sort[1:]
		sort = sort + " DESC"
	} else if strings.HasPrefix(sort, "+") {
		sort = sort[1:]
		sort = sort + " ASC"
	} else {
		sort = sort + " ASC"
	}

	fmt.Println(sort)

	totalRows, err := db.Query("SELECT count(*) from (SELECT s.id as id, s.organization_id as organization_id, s.name as name, s.description as description, s.created_at as created_at, s.updated_at as updated_at FROM services s, versions v WHERE s.id = v.service_id AND (s.name LIKE $1 OR s.description LIKE $1) GROUP BY v.service_id, s.name, s.description, s.created_at, s.updated_at, s.id) AS subquery",
		search)
	if err != nil {
		log.Fatal(err)
	}

	defer totalRows.Close()

	var total int
	for totalRows.Next() {
		if err := totalRows.Scan(&total); err != nil {
			log.Fatal(err)
		}
	}

	rows, err := db.Query("SELECT s.id as id, s.organization_id as organization_id, s.name as name, s.description as description, s.created_at as created_at, s.updated_at as updated_at, count(v.id) as versionsCount FROM services s, versions v WHERE s.id = v.service_id AND (s.name LIKE $1 OR s.description LIKE $2) GROUP BY v.service_id, s.name, s.description, s.created_at, s.updated_at, s.id ORDER BY $3 LIMIT $4 OFFSET $5",
		search, search, sort, size, (page-1)*size)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var services []Service
	for rows.Next() {
		var service Service
		if err := rows.Scan(&service.ID, &service.OrganizationID, &service.Name, &service.Description, &service.CreatedAt, &service.UpdateAt, &service.VersionsCount); err != nil {
			log.Fatal(err)
		}
		services = append(services, service)
	}

	return GenericResponse{Total: total, Data: services}
}

/**
 * Fetch a service by id
 */
func fetchServiceById(id int) Service {
	rows, err := db.Query("SELECT name FROM services WHERE id = $1", id)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var service Service

	for rows.Next() {
		if err := rows.Scan(&service.Name); err != nil {
			log.Fatal(err)
		}
	}

	fmt.Println(service)
	return service
}

/**
 * Fetch a service version by id
 */
func fetchServiceVersionById(serviceId int, versionId int) Versions {
	rows, err := db.Query("SELECT name FROM versions WHERE service_id = $1 AND id = $2", serviceId, versionId)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var version Versions

	for rows.Next() {
		if err := rows.Scan(&version.Name); err != nil {
			log.Fatal(err)
		}
	}

	fmt.Println(version)
	return version
}
