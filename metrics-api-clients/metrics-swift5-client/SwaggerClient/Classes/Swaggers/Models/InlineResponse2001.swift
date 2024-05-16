//
// InlineResponse2001.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct InlineResponse2001: Codable {

    /** ID of the application. */
    public var _id: String?
    /** Name of the application. */
    public var name: String?
    /** Timestamp when the application was created. */
    public var createdAt: Date?
    /** Timestamp when the application was last updated. */
    public var updatedAt: Date?

    public init(_id: String? = nil, name: String? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self._id = _id
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

}
