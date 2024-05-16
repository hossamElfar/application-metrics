/*
 * Your Application API
 *
 * No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)
 *
 * API version: 1.0.0
 * Generated by: Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
 */
package swagger
import (
	"time"
)

type InlineResponse201 struct {
	// ID of the created application.
	Id string `json:"id,omitempty"`
	// Name of the created application.
	Name string `json:"name,omitempty"`
	// Timestamp when the application was created.
	CreatedAt time.Time `json:"created_at,omitempty"`
	// Timestamp when the application was last updated.
	UpdatedAt time.Time `json:"updated_at,omitempty"`
}