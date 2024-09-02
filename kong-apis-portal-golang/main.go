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
	v1.Get("/organizations", handler_organizations) // /api/v1/organizations
	v1.Get("/services", handler_services)           // /api/v1/services
	v1.Get("/services/:id", handler_serviceById)       // /api/v1/services/:id
	v1.Get("/services/:id/versions/:versionId", handler_serviceVersionById) // /api/v1/services/:id/versions/:versionId

	v1.Get("/users", handler_users)                 // /api/v1/user
	v1.Post("/users/:id/login", handlerUserLogin)   // /api/v1/user/:id/login
	v1.Post("/users/:id/password", handlerUserSetPassword) // /api/v1/user/:id/set-password

	app.Listen(":3000")
}

func handler_organizations(c *fiber.Ctx) error {
	return c.SendString("List of organizations")
}


// services
func handler_services(c *fiber.Ctx) error {

	return c.SendString("List of services")
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