package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

type User struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

var db = dbConnect()

func testDb() []User {

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

func dbConnect() *sql.DB {
	connStr := "user=kong password=kong dbname=kong sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	return db
}
