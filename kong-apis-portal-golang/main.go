package main

import (
	"log"
	"strconv"
	"fmt"
	"github.com/gofiber/fiber/v2"
)

func main() {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, World")
	})

	api := app.Group("/api")                        // /api
	v1 := api.Group("/v1")                          // /api/v1
	v1.Get("/organizations", handler_organizations) // /api/v1/organizations
	services := v1.Group("/services", servicesMiddleware) // /api/v1

	services.Get("/", handler_services)                                  // /api/v1/services
	services.Get("/:id", handler_serviceById)                            // /api/v1/services/:id
	services.Get("/:id/versions/:versionId", handler_serviceVersionById) // /api/v1/services/:id/versions/:versionId

	v1.Get("/users", handler_users)                        // /api/v1/user
	v1.Post("/users/:id/login", handlerUserLogin)          // /api/v1/user/:id/login
	v1.Post("/users/:id/password", handlerUserSetPassword) // /api/v1/user/:id/set-password

	
	err := app.Listen(":3000")
	if err != nil {
		log.Fatal(err)
	}
}

func handler_organizations(c *fiber.Ctx) error {
	return c.JSON(fetchOrganizations())
}

// services
func servicesMiddleware(c *fiber.Ctx) error {
	// middleware
	jwt := c.Get("Authorization")

	fmt.Println("middleware JWT", jwt)

	return c.Next()
}

func handler_services(c *fiber.Ctx) error {
	page, err := strconv.Atoi(c.Query("page", "1"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid page"})
	}

	size, err := strconv.Atoi(c.Query("size", "10"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid size"})
	}

	search := c.Query("search", "%")
	sort := c.Query("orderby", "-name")

	return c.JSON(fetchServices(page, size, search, sort))
}

func handler_serviceById(c *fiber.Ctx) error {
	return c.SendString("Service by Id")
}

func handler_serviceVersionById(c *fiber.Ctx) error {
	return c.SendString("Service version by Id")
}

// users
func handler_users(c *fiber.Ctx) error {

	return c.SendString("List of users")
}

func handlerUserLogin(c *fiber.Ctx) error {
	return c.SendString("User login")
}

func handlerUserSetPassword(c *fiber.Ctx) error {
	return c.SendString("User set password")
}
