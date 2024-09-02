package main

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
	"log"
)

const ROUNDS = 10

type User struct {
	ID             string `json:"id"`
	Name           string `json:"name"`
	Email          string `json:"email"`
	OrganizationID string `json:"organization_id"`
	CreatedAt      string `json:"created_at"`
}

type Auth struct {
	ID       string `json:"id"`
	Password string `json:"password"`
}

type Claims struct {
	Username       string `json:"username"`
	OrganizationID string `json:"organization_id"`
}

// users
func handler_users(c *fiber.Ctx) error {

	return c.JSON(fetchUsers())
}

func handlerUserLogin(c *fiber.Ctx) error {
	id := c.Params("id")

	var auth Auth
	if err := c.BodyParser(&auth); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": err.Error()})
	}


	if auth.ID != id {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid user"})
	}

	token := loginUser(id, auth.Password)

	return c.JSON(fiber.Map{"token": token})
}

func handlerUserSetPassword(c *fiber.Ctx) error {
	id := c.Params("id")

	var auth Auth
	if err := c.BodyParser(&auth); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": err.Error()})
	}

	if auth.Password == "" {
		return c.Status(400).JSON(fiber.Map{"error": "Password is required"})
	}

	setUserPassword(id, auth.Password)

	return c.SendString("User set password")
}

/******************** DB queries *******************/

/**
 * Fetch users
 */
func fetchUsers() GenericResponse {
	rows, err := db.Query("SELECT id, name, email, organization_id, created_at  FROM users")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var users []User
	for rows.Next() {
		var user User
		if err := rows.Scan(&user.ID, &user.Name, &user.Email, &user.OrganizationID, &user.CreatedAt); err != nil {
			log.Fatal(err)
		}
		users = append(users, user)
	}

	totalRows, err := db.Query("SELECT COUNT(*) FROM users")
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

	return GenericResponse{Data: users, Total: total}
}

/**
 * Set user password
 */
func setUserPassword(id string, password string) {
	// encrypt password
	hash, errr := HashPassword(password)
	if errr != nil {
		log.Fatal(errr)
	}

	// update password
	_, err := db.Exec("UPDATE users SET password = $1 WHERE id = $2", hash, id)
	if err != nil {
		log.Fatal(err)
	}
}

/**
 * Login user
 */
func loginUser(id string, password string) string {
	// get user
	rows, err := db.Query("SELECT id, password, email, organization_id FROM users WHERE id = $1", id)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var auth Auth
	var user User

	for rows.Next() {
		if err := rows.Scan(&user.ID, &auth.Password, &user.Email, &user.OrganizationID); err != nil {
			log.Fatal(err)
		}
		auth.ID = user.ID
	}

	log.Println(user, password)
	// check password
	if !CheckPasswordHash(password, auth.Password) {
		log.Fatal("Invalid password")
	}

	// generate token
	token := jwt.New(jwt.SigningMethodHS256)
	claims := token.Claims.(jwt.MapClaims)
	claims["username"] = user.Email
	claims["organization_id"] = user.OrganizationID

	tokenString, err := token.SignedString([]byte("secret"))
	if err != nil {
		log.Fatal(err)
	}

	return tokenString
}

/**
 * Hash password
 */
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func CheckPasswordHash(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	if err != nil {
		log.Println(err)
	}
	return err == nil
}
