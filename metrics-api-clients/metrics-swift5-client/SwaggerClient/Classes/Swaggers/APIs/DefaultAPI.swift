//
// DefaultAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class DefaultAPI {
    /**
     Get an application by ID

     - parameter appId: (path) ID of the application to retrieve. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiV1ApplicationsAppIdGet(appId: String, completion: @escaping ((_ data: InlineResponse2001?,_ error: Error?) -> Void)) {
        apiV1ApplicationsAppIdGetWithRequestBuilder(appId: appId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get an application by ID
     - GET /api/v1/applications/{app_id}

     - examples: [{contentType=application/json, example={
  "updated_at" : "2000-01-23T04:56:07.000+00:00",
  "name" : "name",
  "created_at" : "2000-01-23T04:56:07.000+00:00",
  "id" : "id"
}}]
     - parameter appId: (path) ID of the application to retrieve. 

     - returns: RequestBuilder<InlineResponse2001> 
     */
    open class func apiV1ApplicationsAppIdGetWithRequestBuilder(appId: String) -> RequestBuilder<InlineResponse2001> {
        var path = "/api/v1/applications/{app_id}"
        let appIdPreEscape = "\(appId)"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<InlineResponse2001>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**
     * enum for parameter duration
     */
    public enum Duration_apiV1ApplicationsAppIdMetricsMetricNameGet: String { 
        case hour = "hour"
        case day = "day"
        case week = "week"
        case month = "month"
        case quarter = "quarter"
        case year = "year"
    }

    /**
     Get metrics for a specific metric of an application

     - parameter appId: (path) ID of the application. 
     - parameter metricName: (path) Name of the metric. 
     - parameter duration: (query) Duration for which the metrics should be aggregated. Available options are hour, day, week, month, quarter, year. Defaulted to &#x27;hour&#x27;.  (optional, default to hour)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiV1ApplicationsAppIdMetricsMetricNameGet(appId: String, metricName: String, duration: Duration_apiV1ApplicationsAppIdMetricsMetricNameGet? = nil, completion: @escaping ((_ data: [InlineResponse2003]?,_ error: Error?) -> Void)) {
        apiV1ApplicationsAppIdMetricsMetricNameGetWithRequestBuilder(appId: appId, metricName: metricName, duration: duration).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get metrics for a specific metric of an application
     - GET /api/v1/applications/{app_id}/metrics/{metric_name}

     - examples: [{contentType=application/json, example=[ {
  "date" : "2024-05-06T00:00:00Z",
  "p99" : 30,
  "avg" : 12.666666666666666,
  "count" : 3,
  "p50" : 5,
  "p95" : 30
}, {
  "date" : "2024-05-06T00:00:00Z",
  "p99" : 30,
  "avg" : 12.666666666666666,
  "count" : 3,
  "p50" : 5,
  "p95" : 30
} ]}]
     - parameter appId: (path) ID of the application. 
     - parameter metricName: (path) Name of the metric. 
     - parameter duration: (query) Duration for which the metrics should be aggregated. Available options are hour, day, week, month, quarter, year. Defaulted to &#x27;hour&#x27;.  (optional, default to hour)

     - returns: RequestBuilder<[InlineResponse2003]> 
     */
    open class func apiV1ApplicationsAppIdMetricsMetricNameGetWithRequestBuilder(appId: String, metricName: String, duration: Duration_apiV1ApplicationsAppIdMetricsMetricNameGet? = nil) -> RequestBuilder<[InlineResponse2003]> {
        var path = "/api/v1/applications/{app_id}/metrics/{metric_name}"
        let appIdPreEscape = "\(appId)"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let metricNamePreEscape = "\(metricName)"
        let metricNamePostEscape = metricNamePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{metric_name}", with: metricNamePostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "duration": duration?.rawValue
        ])


        let requestBuilder: RequestBuilder<[InlineResponse2003]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**
     Add metrics for an application

     - parameter body: (body)  
     - parameter appId: (path) ID of the application to which metrics are being added. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiV1ApplicationsAppIdMetricsPost(body: AppIdMetricsBody, appId: String, completion: @escaping ((_ data: InlineResponse2002?,_ error: Error?) -> Void)) {
        apiV1ApplicationsAppIdMetricsPostWithRequestBuilder(body: body, appId: appId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add metrics for an application
     - POST /api/v1/applications/{app_id}/metrics

     - examples: [{contentType=application/json, example={
  "message" : "Metric(s) added successfully."
}}]
     - parameter body: (body)  
     - parameter appId: (path) ID of the application to which metrics are being added. 

     - returns: RequestBuilder<InlineResponse2002> 
     */
    open class func apiV1ApplicationsAppIdMetricsPostWithRequestBuilder(body: AppIdMetricsBody, appId: String) -> RequestBuilder<InlineResponse2002> {
        var path = "/api/v1/applications/{app_id}/metrics"
        let appIdPreEscape = "\(appId)"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<InlineResponse2002>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    /**
     Get a list of applications

     - parameter page: (query) Page number for pagination. (optional)
     - parameter perPage: (query) Number of applications per page for pagination. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiV1ApplicationsGet(page: Int? = nil, perPage: Int? = nil, completion: @escaping ((_ data: InlineResponse200?,_ error: Error?) -> Void)) {
        apiV1ApplicationsGetWithRequestBuilder(page: page, perPage: perPage).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get a list of applications
     - GET /api/v1/applications

     - examples: [{contentType=application/json, example={
  "records" : [ {
    "updated_at" : "2000-01-23T04:56:07.000+00:00",
    "name" : "name",
    "created_at" : "2000-01-23T04:56:07.000+00:00",
    "id" : "id"
  }, {
    "updated_at" : "2000-01-23T04:56:07.000+00:00",
    "name" : "name",
    "created_at" : "2000-01-23T04:56:07.000+00:00",
    "id" : "id"
  } ],
  "meta" : {
    "count" : "count",
    "page" : 0,
    "items" : 6
  }
}}]
     - parameter page: (query) Page number for pagination. (optional)
     - parameter perPage: (query) Number of applications per page for pagination. (optional)

     - returns: RequestBuilder<InlineResponse200> 
     */
    open class func apiV1ApplicationsGetWithRequestBuilder(page: Int? = nil, perPage: Int? = nil) -> RequestBuilder<InlineResponse200> {
        let path = "/api/v1/applications"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "page": page?.encodeToJSON(), 
                        "per_page": perPage?.encodeToJSON()
        ])


        let requestBuilder: RequestBuilder<InlineResponse200>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    /**
     Create a new application

     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiV1ApplicationsPost(body: V1ApplicationsBody, completion: @escaping ((_ data: InlineResponse201?,_ error: Error?) -> Void)) {
        apiV1ApplicationsPostWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Create a new application
     - POST /api/v1/applications

     - examples: [{contentType=application/json, example={
  "updated_at" : "2000-01-23T04:56:07.000+00:00",
  "name" : "name",
  "created_at" : "2000-01-23T04:56:07.000+00:00",
  "id" : "id"
}}]
     - parameter body: (body)  

     - returns: RequestBuilder<InlineResponse201> 
     */
    open class func apiV1ApplicationsPostWithRequestBuilder(body: V1ApplicationsBody) -> RequestBuilder<InlineResponse201> {
        let path = "/api/v1/applications"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<InlineResponse201>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}