package main

import (
	"github.com/gofiber/fiber/v2"
)

func main() {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		users := testDb()
		return c.JSON(users)
	})

	api := app.Group("/api")                        // /api
	v1 := api.Group("/v1")                          // /api/v1
	v1.Get("/organizations", handler_organizations) // /api/v1/user
	v1.Get("/users", handler_users)                 // /api/v1/user
	v1.Get("/services", handler_services)           // /api/v1/user

	app.Listen(":3000")
}

func handler_organizations(c *fiber.Ctx) error {
	return c.SendString("List of organizations")
}

func handler_users(c *fiber.Ctx) error {

	return c.SendString("List of users")
}

func handler_services(c *fiber.Ctx) error {

	return c.SendString("List of services")
}
