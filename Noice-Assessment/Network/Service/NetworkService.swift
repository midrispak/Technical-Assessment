//
//  Service.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 19/02/2022.
//

import Foundation
import Alamofire

final class NetworkService: NetworkServiceProtocol {
    
    func sendRequest(_ requestConvertible: URLRequestConvertible, completion: @escaping CompletionBlock) {
        
        AF.request(requestConvertible).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error as NSError?)
            }
        }
    }
}
