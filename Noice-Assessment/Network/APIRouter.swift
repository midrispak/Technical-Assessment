//
//  APIRouter.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 21/02/2022.
//

import Foundation
import Alamofire

typealias ParamDictionary = [String : Any]

enum APIRouter: URLRequestConvertible {
    
    case loadComments(ParamDictionary)
    case saveComment(ParamDictionary)
    
    func asURLRequest() throws -> URLRequest {
        let absoluteString = "\(Constants.baseURL)\(relativePath)"
        let absoluteURL = URL(string: absoluteString)!
        var urlRequest = URLRequest(url: absoluteURL)
        urlRequest.httpMethod = requestMethod.rawValue
        urlRequest.timeoutInterval = Constants.Values.timeoutInterval
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let authToken = "Bearer \(Constants.Values.authToken)"
        urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        switch self {
            
        case .loadComments(var params), .saveComment(var params):
            params["format"] = "json"
            return try encoding.encode(urlRequest, with: params)
        }
    }
    
    var encoding: ParameterEncoding {
        switch self.requestMethod {
            case .get:
              return URLEncoding.default
            default:
              return JSONEncoding.default
          }
        }
    
    var relativePath: String {
        switch self {
        case .loadComments:
            return "/community-api/v1/post/e0000b7c-185f-4af0-9e3b-c1dcc6a22757?limit=10&page=1"
        case .saveComment:
            return "/community-api/v1/post"
        }
    }
    
    var requestMethod: HTTPMethod {
        switch self {
        case .loadComments:
            return .get
        case .saveComment:
            return .post
        }
    }
}

enum Environment {
    case dev, qa, staging, prod
    var baseURL: String {
        switch self {
        case .dev, .qa, .staging, .prod:
            return "https://api.dev.noice.id/"
        }
    }
}

struct Constants {
    
    static let currentEnv: Environment = .dev
    static var baseURL: String {
        currentEnv.baseURL
    }
    
    enum Values {
        static let timeoutInterval = 20.0
        // TODO: Save in UserSession and retrieve it from there
        static let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InNpbV9rZXlfdjEifQ.eyJpZCI6IjQ5YjU0MWViLWJjNWUtNDkwOS05YTdiLTViMzMyOWNkMjNkMyIsInJvbGVzIjpbInVzZXIiXSwiaWF0IjoxNjQ0OTg5ODY0LCJleHAiOjE2NDQ5OTM0NjR9.psmCHwgqEeaehIfRDReey1iO9XhCyYuNTfPAKtP8ryE"
    }
}
