/*
 * Your Application API
 *
 * No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)
 *
 * API version: 1.0.0
 * Generated by: Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
 */
package swagger

type Apiv1applicationsappIdmetricsMetrics struct {
	// Name of the metric.
	Name string `json:"name,omitempty"`
	// Value of the metric.
	Value float64 `json:"value,omitempty"`
	// Unix timestamp of when the metric was recorded.
	Timestamp int64 `json:"timestamp,omitempty"`
}
