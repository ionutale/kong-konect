package main

import (
	"fmt"

	"github.com/gofiber/fiber/v2"
)

// services
func servicesMiddleware(c *fiber.Ctx) error {
	// middleware
	jwt := c.Get("Authorization")

	fmt.Println("middleware JWT", jwt)

	return c.Next()
}
