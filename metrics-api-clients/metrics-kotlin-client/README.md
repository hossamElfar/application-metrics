# io.swagger.client - Kotlin client library for Your Application API

## Requires

* Kotlin 1.4.30
* Gradle 5.3

## Build

First, create the gradle wrapper script:

```
gradle wrapper
```

Then, run:

```
./gradlew check assemble
```

This runs all tests and packages the library.

## Features/Implementation Notes

* Supports JSON inputs/outputs, File inputs, and Form inputs.
* Supports collection formats for query parameters: csv, tsv, ssv, pipes.
* Some Kotlin and Java types are fully qualified to avoid conflicts with types defined in Swagger definitions.
* Implementation of ApiClient is intended to reduce method counts, specifically to benefit Android targets.

<a name="documentation-for-api-endpoints"></a>
## Documentation for API Endpoints

All URIs are relative to */*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*DefaultApi* | [**apiV1ApplicationsAppIdGet**](docs/DefaultApi.md#apiv1applicationsappidget) | **GET** /api/v1/applications/{app_id} | Get an application by ID
*DefaultApi* | [**apiV1ApplicationsAppIdMetricsMetricNameGet**](docs/DefaultApi.md#apiv1applicationsappidmetricsmetricnameget) | **GET** /api/v1/applications/{app_id}/metrics/{metric_name} | Get metrics for a specific metric of an application
*DefaultApi* | [**apiV1ApplicationsAppIdMetricsPost**](docs/DefaultApi.md#apiv1applicationsappidmetricspost) | **POST** /api/v1/applications/{app_id}/metrics | Add metrics for an application
*DefaultApi* | [**apiV1ApplicationsGet**](docs/DefaultApi.md#apiv1applicationsget) | **GET** /api/v1/applications | Get a list of applications
*DefaultApi* | [**apiV1ApplicationsPost**](docs/DefaultApi.md#apiv1applicationspost) | **POST** /api/v1/applications | Create a new application

<a name="documentation-for-models"></a>
## Documentation for Models

 - [io.swagger.client.models.Apiv1applicationsApplication](docs/Apiv1applicationsApplication.md)
 - [io.swagger.client.models.Apiv1applicationsappIdmetricsMetrics](docs/Apiv1applicationsappIdmetricsMetrics.md)
 - [io.swagger.client.models.AppIdMetricsBody](docs/AppIdMetricsBody.md)
 - [io.swagger.client.models.InlineResponse200](docs/InlineResponse200.md)
 - [io.swagger.client.models.InlineResponse2001](docs/InlineResponse2001.md)
 - [io.swagger.client.models.InlineResponse2002](docs/InlineResponse2002.md)
 - [io.swagger.client.models.InlineResponse2003](docs/InlineResponse2003.md)
 - [io.swagger.client.models.InlineResponse201](docs/InlineResponse201.md)
 - [io.swagger.client.models.InlineResponse400](docs/InlineResponse400.md)
 - [io.swagger.client.models.InlineResponse404](docs/InlineResponse404.md)
 - [io.swagger.client.models.InlineResponse4041](docs/InlineResponse4041.md)
 - [io.swagger.client.models.V1ApplicationsBody](docs/V1ApplicationsBody.md)

<a name="documentation-for-authorization"></a>
## Documentation for Authorization

All endpoints do not require authorization.
