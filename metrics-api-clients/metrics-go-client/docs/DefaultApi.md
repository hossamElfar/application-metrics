# {{classname}}

All URIs are relative to */*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ApiV1ApplicationsAppIdGet**](DefaultApi.md#ApiV1ApplicationsAppIdGet) | **Get** /api/v1/applications/{app_id} | Get an application by ID
[**ApiV1ApplicationsAppIdMetricsMetricNameGet**](DefaultApi.md#ApiV1ApplicationsAppIdMetricsMetricNameGet) | **Get** /api/v1/applications/{app_id}/metrics/{metric_name} | Get metrics for a specific metric of an application
[**ApiV1ApplicationsAppIdMetricsPost**](DefaultApi.md#ApiV1ApplicationsAppIdMetricsPost) | **Post** /api/v1/applications/{app_id}/metrics | Add metrics for an application
[**ApiV1ApplicationsGet**](DefaultApi.md#ApiV1ApplicationsGet) | **Get** /api/v1/applications | Get a list of applications
[**ApiV1ApplicationsPost**](DefaultApi.md#ApiV1ApplicationsPost) | **Post** /api/v1/applications | Create a new application

# **ApiV1ApplicationsAppIdGet**
> InlineResponse2001 ApiV1ApplicationsAppIdGet(ctx, appId)
Get an application by ID

Retrieve an application by its ID.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
  **appId** | **string**| ID of the application to retrieve. | 

### Return type

[**InlineResponse2001**](inline_response_200_1.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ApiV1ApplicationsAppIdMetricsMetricNameGet**
> []InlineResponse2003 ApiV1ApplicationsAppIdMetricsMetricNameGet(ctx, appId, metricName, optional)
Get metrics for a specific metric of an application

Retrieve metrics for a specific metric of an application.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
  **appId** | **string**| ID of the application. | 
  **metricName** | **string**| Name of the metric. | 
 **optional** | ***DefaultApiApiV1ApplicationsAppIdMetricsMetricNameGetOpts** | optional parameters | nil if no parameters

### Optional Parameters
Optional parameters are passed through a pointer to a DefaultApiApiV1ApplicationsAppIdMetricsMetricNameGetOpts struct
Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------


 **duration** | **optional.String**| Duration for which the metrics should be aggregated. Available options are hour, day, week, month, quarter, year. Defaulted to &#x27;hour&#x27;.  | [default to hour]

### Return type

[**[]InlineResponse2003**](inline_response_200_3.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ApiV1ApplicationsAppIdMetricsPost**
> InlineResponse2002 ApiV1ApplicationsAppIdMetricsPost(ctx, body, appId)
Add metrics for an application

Endpoint to add metrics for a specific application.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
  **body** | [**AppIdMetricsBody**](AppIdMetricsBody.md)|  | 
  **appId** | **string**| ID of the application to which metrics are being added. | 

### Return type

[**InlineResponse2002**](inline_response_200_2.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ApiV1ApplicationsGet**
> InlineResponse200 ApiV1ApplicationsGet(ctx, optional)
Get a list of applications

Retrieve a list of applications.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
 **optional** | ***DefaultApiApiV1ApplicationsGetOpts** | optional parameters | nil if no parameters

### Optional Parameters
Optional parameters are passed through a pointer to a DefaultApiApiV1ApplicationsGetOpts struct
Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **optional.Int32**| Page number for pagination. | 
 **perPage** | **optional.Int32**| Number of applications per page for pagination. | 

### Return type

[**InlineResponse200**](inline_response_200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ApiV1ApplicationsPost**
> InlineResponse201 ApiV1ApplicationsPost(ctx, body)
Create a new application

Endpoint to create a new application.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
  **body** | [**V1ApplicationsBody**](V1ApplicationsBody.md)|  | 

### Return type

[**InlineResponse201**](inline_response_201.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

