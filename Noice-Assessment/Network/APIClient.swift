//
//  APIClient.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 19/02/2022.
//

import Foundation
import Alamofire

final class APIClient {
    
    // MARK: - Properties
    private var networkService: NetworkServiceProtocol
    private var middleware: APIClientMiddlewareProtocol
    
    static let standard = APIClient(networkService: NetworkService(),
                                    middleware: APIClientMiddleware())
    
    // MARK: - Methods
    init(networkService: NetworkServiceProtocol, middleware: APIClientMiddlewareProtocol) {
        self.networkService = networkService
        self.middleware = middleware
    }
    
    func callGenericAPI<T: URLRequestConvertible, R: Codable>(request: T, completion: @escaping ((Result<R, Error>) -> Void )) {
        
        // CompletionBlock
        networkService.sendRequest(request) { (data, error) in
            
        }
    }
}
