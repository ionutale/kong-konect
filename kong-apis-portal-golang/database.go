package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/google/uuid"
	_ "github.com/lib/pq"
	"github.com/joho/godotenv"
)

type myUUID uuid.UUID

type GenericResponse struct {
	Total int
	Data  interface{}
}

type ServiceWithVersions struct {
	Service Service
	Version []Version
}

type Organization struct {
	ID          string `json:"id"`
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

	Versions []Version `json:"versions,omitempty"` // Optional field for versions
}

type Version struct {
	ID          string `json:"id"`
	ServiceID   string `json:"service_id"`
	Version     string `json:"version"`
	Name        string `json:"name"`
	Description string `json:"description"`
	CreatedAt   string `json:"created_at"`
}

var db = dbConnect()

func dbConnect() *sql.DB {
  err := godotenv.Load()
  if err != nil {
    log.Fatal("Error loading .env file")
  }


	var (
    host     = os.Getenv("DB_HOST")
    port     = os.Getenv("DB_PORT")
    user     = os.Getenv("DB_USER")
    password = os.Getenv("DB_PASSWORD")
    dbname   = os.Getenv("DB_NAME")
)

	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)
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
func fetchServices(organization_id string, page int, size int, search string, sort string) GenericResponse {

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

	totalRows, err := db.Query("SELECT count(*) from (SELECT s.id as id, s.organization_id as organization_id, s.name as name, s.description as description, s.created_at as created_at, s.updated_at as updated_at FROM services s, versions v WHERE s.organization_id = $1 AND s.id = v.service_id AND (s.name LIKE $2 OR s.description LIKE $2) GROUP BY v.service_id, s.name, s.description, s.created_at, s.updated_at, s.id) AS subquery",
		organization_id, search)
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

	rows, err := db.Query("SELECT s.id as id, s.organization_id as organization_id, s.name as name, s.description as description, s.created_at as created_at, s.updated_at as updated_at, count(v.id) as versionsCount FROM services s, versions v WHERE s.organization_id = $1 AND s.id = v.service_id AND (s.name LIKE $2 OR s.description LIKE $3) GROUP BY v.service_id, s.name, s.description, s.created_at, s.updated_at, s.id ORDER BY $4 LIMIT $5 OFFSET $6",
		organization_id, search, search, sort, size, (page-1)*size)
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
func fetchServiceById(organization_id string, id string) Service {
	rows, err := db.Query("SELECT s.id as id, s.organization_id as organization_id, s.name as name, s.description as description, s.created_at as created_at, s.updated_at as updated_at, v.id as versionId, v.version FROM services s LEFT JOIN versions v ON s.id = v.service_id WHERE s.organization_id = $1 AND s.id = $2", organization_id, id)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var service Service
	var versions []Version
	for rows.Next() {
		var version Version
		if err := rows.Scan(
			&service.ID,
			&service.OrganizationID,
			&service.Name,
			&service.Description,
			&service.CreatedAt,
			&service.UpdateAt,
			&version.ID,
			&version.Version,
		); err != nil {
			log.Fatal(err)
		}
		versions = append(versions, version)
	}

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	service.Versions = versions

	return service
}

/**
 * Fetch a service version by id
 */
func fetchServiceVersionById(organization_id string, serviceId string, versionId string) Service {
	rows, err := db.Query("SELECT s.id as id, s.organization_id as organization_id, s.name as name, s.description as description, s.created_at as created_at, s.updated_at as updated_at, v.id as versionId, v.version, v.name, v.description, v.created_at FROM services s LEFT JOIN versions v ON s.id = v.service_id WHERE s.organization_id = $1 AND s.id = $2 and v.id = $3",
		organization_id,
		serviceId,
		versionId)

	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var service Service
	var version Version
	for rows.Next() {
		if err := rows.Scan(
			&service.ID,
			&service.OrganizationID,
			&service.Name,
			&service.Description,
			&service.CreatedAt,
			&service.UpdateAt,
			&version.ID,
			&version.Version,
			&version.Name,
			&version.Description,
			&version.CreatedAt,
		); err != nil {
			log.Fatal(err)
		}
	}

	service.Versions = append(service.Versions, version)

	return service
}
