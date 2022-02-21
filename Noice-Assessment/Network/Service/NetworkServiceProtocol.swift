//
//  NetworkServiceProtocol.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 19/02/2022.
//

import Foundation
import Alamofire

typealias CompletionBlock = (_ data: Data?, _ error: NSError?) -> Void

protocol NetworkServiceProtocol {
        
    func sendRequest(_ requestConvertible: URLRequestConvertible, completion: @escaping CompletionBlock)
}
