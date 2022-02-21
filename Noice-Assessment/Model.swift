//
//  Model.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 16/02/2022.
//

import Foundation

// MARK: - Welcome
struct CommentResponse: Codable {
    let data: [Datum]
    let message: String
    let meta: WelcomeMeta
    let statusCode: Int
}

// MARK: - Datum
struct Datum: Codable {
    let createdAt, id: String
    let isActive: Bool
    let message: String
    let meta: DatumMeta
    let parentID: String
    let photo: String
    let replyCount: Int
    let type: TypeEnum
    let updatedAt: String
    let user: User
    let userID: String
    let userName: UserName

    enum CodingKeys: String, CodingKey {
        case createdAt, id, isActive, message, meta
        case parentID = "parentId"
        case photo, replyCount, type, updatedAt, user
        case userID = "userId"
        case userName
    }
}

// MARK: - DatumMeta
struct DatumMeta: Codable {
    let aggregations: Aggregations
    let isReported: Bool
    let userActions: [UserAction]
}

// MARK: - Aggregations
struct Aggregations: Codable {
    let dislikes, likes: Int
}

// MARK: - UserAction
struct UserAction: Codable {
    let action: Action
    let actionValue, createdAt, entityID: String
    let entitySubType: TypeEnum
    let entityType: Action
    let id: String
    let metadata: JSONNull?
    let updatedAt, userID: String

    enum CodingKeys: String, CodingKey {
        case action, actionValue, createdAt
        case entityID = "entityId"
        case entitySubType, entityType, id, metadata, updatedAt
        case userID = "userId"
    }
}

enum Action: String, Codable {
    case post = "post"
}

enum TypeEnum: String, Codable {
    case comment = "comment"
}

// MARK: - User
struct User: Codable {
    let artistID: JSONNull?
    let bio: String
    let createdAt: CreatedAt
    let displayName: DisplayName
    let dob: String
    let gender: Gender
    let id: String
    let isOnboardingComplete, isVerified: Bool
    let photo: String
    let role: Role
    let tncAccepted: Bool
    let updatedAt: UpdatedAt
    let userName: UserName

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case bio, createdAt, displayName, dob, gender, id, isOnboardingComplete, isVerified, photo, role, tncAccepted, updatedAt, userName
    }
}

enum CreatedAt: String, Codable {
    case the20210129T154100000Z = "2021-01-29T15:41:00.000Z"
}

enum DisplayName: String, Codable {
    case sahilJadon = "Sahil Jadon"
}

enum Gender: String, Codable {
    case male = "male"
}

enum Role: String, Codable {
    case user = "user"
}

enum UpdatedAt: String, Codable {
    case the20211216T132922000Z = "2021-12-16T13:29:22.000Z"
}

enum UserName: String, Codable {
    case sahiljadon1 = "sahiljadon1"
}

// MARK: - WelcomeMeta
struct WelcomeMeta: Codable {
    let limit, page, totalCount: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

struct Comment: Codable {
    let message, parentID: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case message, type
        case parentID = "parentId"
    }
}
