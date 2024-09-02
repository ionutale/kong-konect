package main

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/google/uuid"
	_ "github.com/lib/pq"
)

type myUUID uuid.UUID

type User struct {
	ID             int    `json:UUID`
	Name           string `json:"name"`
	Email          string `json:"email"`
	OrganizationID int    `json:"organization_id"`
	CreatedAt      string `json:"created_at"`
}

type Organization struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
	CreatedAt   string `json:"created_at"`
}

type Service struct {
	Id             string `json:"id" db:"id"`
	OrganizationID string `json:"organization_id"`
	Name           string `json:"name"`
	Description    string `json:"description"`
	CreatedAt      string `json:"created_at"`
	UpdateAt       string `json:"update_at"`
}

type Versions struct {
	ID          int    `json:"id"`
	ServiceID   int    `json:"service_id"`
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
		log.Fatal(err)
	}

	return db
}

func fetchUsers() []User {

	rows, err := db.Query("SELECT name FROM users")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var users []User
	for rows.Next() {
		var user User
		if err := rows.Scan(&user.Name); err != nil {
			log.Fatal(err)
		}
		users = append(users, user)
	}

	fmt.Println(users)

	return users
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

// services
func fetchServices(page int, size int, search string, sort string) []Service {

	var query string
	if search != "" {
		query = fmt.Sprintf("SELECT * FROM services WHERE name LIKE '%%%s%%' ORDER BY %s LIMIT %d OFFSET %d", search, sort, size, (page-1)*size)
	} else {
		query = fmt.Sprintf("SELECT * FROM services ORDER BY %s LIMIT %d OFFSET %d", sort, size, (page-1)*size)
	}

	rows, err := db.Query(query)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var services []Service
	for rows.Next() {
		var service Service
    if err := rows.Scan(&service.Id, &service.OrganizationID, &service.Name, &service.Description, &service.CreatedAt, &service.UpdateAt); err != nil {
			log.Fatal(err)
		}
		services = append(services, service)
	}

	return services
}

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
