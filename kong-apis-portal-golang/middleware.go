package main

import (
	"fmt"

	"github.com/gofiber/fiber/v2"
)

// services
func servicesMiddleware(c *fiber.Ctx) error {
	// middleware
	authorization := c.Get("Authorization")
	jwt := authorization[7:]
	organization_id := decodeToken(jwt)
	fmt.Println("middleware JWT", organization_id)

	c.Locals("organization_id", organization_id)

	return c.Next()
}
