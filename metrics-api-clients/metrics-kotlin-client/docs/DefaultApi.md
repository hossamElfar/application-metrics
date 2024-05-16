# DefaultApi

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1ApplicationsAppIdGet**](DefaultApi.md#apiV1ApplicationsAppIdGet) | **GET** /api/v1/applications/{app_id} | Get an application by ID
[**apiV1ApplicationsAppIdMetricsMetricNameGet**](DefaultApi.md#apiV1ApplicationsAppIdMetricsMetricNameGet) | **GET** /api/v1/applications/{app_id}/metrics/{metric_name} | Get metrics for a specific metric of an application
[**apiV1ApplicationsAppIdMetricsPost**](DefaultApi.md#apiV1ApplicationsAppIdMetricsPost) | **POST** /api/v1/applications/{app_id}/metrics | Add metrics for an application
[**apiV1ApplicationsGet**](DefaultApi.md#apiV1ApplicationsGet) | **GET** /api/v1/applications | Get a list of applications
[**apiV1ApplicationsPost**](DefaultApi.md#apiV1ApplicationsPost) | **POST** /api/v1/applications | Create a new application

<a name="apiV1ApplicationsAppIdGet"></a>
# **apiV1ApplicationsAppIdGet**
> InlineResponse2001 apiV1ApplicationsAppIdGet(appId)

Get an application by ID

Retrieve an application by its ID.

### Example
```kotlin
// Import classes:
//import io.swagger.client.infrastructure.*
//import io.swagger.client.models.*;

val apiInstance = DefaultApi()
val appId : kotlin.String = appId_example // kotlin.String | ID of the application to retrieve.
try {
    val result : InlineResponse2001 = apiInstance.apiV1ApplicationsAppIdGet(appId)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling DefaultApi#apiV1ApplicationsAppIdGet")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling DefaultApi#apiV1ApplicationsAppIdGet")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appId** | **kotlin.String**| ID of the application to retrieve. |

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

<a name="apiV1ApplicationsAppIdMetricsMetricNameGet"></a>
# **apiV1ApplicationsAppIdMetricsMetricNameGet**
> kotlin.Array&lt;InlineResponse2003&gt; apiV1ApplicationsAppIdMetricsMetricNameGet(appId, metricName, duration)

Get metrics for a specific metric of an application

Retrieve metrics for a specific metric of an application.

### Example
```kotlin
// Import classes:
//import io.swagger.client.infrastructure.*
//import io.swagger.client.models.*;

val apiInstance = DefaultApi()
val appId : kotlin.String = appId_example // kotlin.String | ID of the application.
val metricName : kotlin.String = metricName_example // kotlin.String | Name of the metric.
val duration : kotlin.String = duration_example // kotlin.String | Duration for which the metrics should be aggregated. Available options are hour, day, week, month, quarter, year. Defaulted to 'hour'. 
try {
    val result : kotlin.Array<InlineResponse2003> = apiInstance.apiV1ApplicationsAppIdMetricsMetricNameGet(appId, metricName, duration)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling DefaultApi#apiV1ApplicationsAppIdMetricsMetricNameGet")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling DefaultApi#apiV1ApplicationsAppIdMetricsMetricNameGet")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appId** | **kotlin.String**| ID of the application. |
 **metricName** | **kotlin.String**| Name of the metric. |
 **duration** | **kotlin.String**| Duration for which the metrics should be aggregated. Available options are hour, day, week, month, quarter, year. Defaulted to &#x27;hour&#x27;.  | [optional] [default to hour] [enum: hour, day, week, month, quarter, year]

### Return type

[**kotlin.Array&lt;InlineResponse2003&gt;**](InlineResponse2003.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

<a name="apiV1ApplicationsAppIdMetricsPost"></a>
# **apiV1ApplicationsAppIdMetricsPost**
> InlineResponse2002 apiV1ApplicationsAppIdMetricsPost(body, appId)

Add metrics for an application

Endpoint to add metrics for a specific application.

### Example
```kotlin
// Import classes:
//import io.swagger.client.infrastructure.*
//import io.swagger.client.models.*;

val apiInstance = DefaultApi()
val body : AppIdMetricsBody =  // AppIdMetricsBody | 
val appId : kotlin.String = appId_example // kotlin.String | ID of the application to which metrics are being added.
try {
    val result : InlineResponse2002 = apiInstance.apiV1ApplicationsAppIdMetricsPost(body, appId)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling DefaultApi#apiV1ApplicationsAppIdMetricsPost")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling DefaultApi#apiV1ApplicationsAppIdMetricsPost")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**AppIdMetricsBody**](AppIdMetricsBody.md)|  |
 **appId** | **kotlin.String**| ID of the application to which metrics are being added. |

### Return type

[**InlineResponse2002**](InlineResponse2002.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

<a name="apiV1ApplicationsGet"></a>
# **apiV1ApplicationsGet**
> InlineResponse200 apiV1ApplicationsGet(page, perPage)

Get a list of applications

Retrieve a list of applications.

### Example
```kotlin
// Import classes:
//import io.swagger.client.infrastructure.*
//import io.swagger.client.models.*;

val apiInstance = DefaultApi()
val page : kotlin.Int = 56 // kotlin.Int | Page number for pagination.
val perPage : kotlin.Int = 56 // kotlin.Int | Number of applications per page for pagination.
try {
    val result : InlineResponse200 = apiInstance.apiV1ApplicationsGet(page, perPage)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling DefaultApi#apiV1ApplicationsGet")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling DefaultApi#apiV1ApplicationsGet")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **kotlin.Int**| Page number for pagination. | [optional]
 **perPage** | **kotlin.Int**| Number of applications per page for pagination. | [optional]

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

<a name="apiV1ApplicationsPost"></a>
# **apiV1ApplicationsPost**
> InlineResponse201 apiV1ApplicationsPost(body)

Create a new application

Endpoint to create a new application.

### Example
```kotlin
// Import classes:
//import io.swagger.client.infrastructure.*
//import io.swagger.client.models.*;

val apiInstance = DefaultApi()
val body : V1ApplicationsBody =  // V1ApplicationsBody | 
try {
    val result : InlineResponse201 = apiInstance.apiV1ApplicationsPost(body)
    println(result)
} catch (e: ClientException) {
    println("4xx response calling DefaultApi#apiV1ApplicationsPost")
    e.printStackTrace()
} catch (e: ServerException) {
    println("5xx response calling DefaultApi#apiV1ApplicationsPost")
    e.printStackTrace()
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**V1ApplicationsBody**](V1ApplicationsBody.md)|  |

### Return type

[**InlineResponse201**](InlineResponse201.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

