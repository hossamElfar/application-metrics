/**
 * Your Application API
 * No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)
 *
 * OpenAPI spec version: 1.0.0
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */
package io.swagger.client.models


/**
 * 
 * @param id ID of the application.
 * @param name Name of the application.
 * @param createdAt Timestamp when the application was created.
 * @param updatedAt Timestamp when the application was last updated.
 */
data class InlineResponse2001 (

    /* ID of the application. */
    val id: kotlin.String? = null,
    /* Name of the application. */
    val name: kotlin.String? = null,
    /* Timestamp when the application was created. */
    val createdAt: java.time.LocalDateTime? = null,
    /* Timestamp when the application was last updated. */
    val updatedAt: java.time.LocalDateTime? = null
) {
}