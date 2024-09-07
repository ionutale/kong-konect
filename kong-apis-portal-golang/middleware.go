package main

import (
	"github.com/gofiber/fiber/v2"
)

// services
func servicesMiddleware(c *fiber.Ctx) error {
	// middleware
	authorization := c.Get("Authorization")
	jwt := authorization[7:]
	organizationId := decodeToken(jwt)

	c.Locals("organization_id", organizationId)

	return c.Next()
}
