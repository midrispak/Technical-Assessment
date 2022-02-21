//
//  APIClientMiddlewareProtocol.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 19/02/2022.
//

import Foundation

protocol APIClientMiddlewareProtocol {
    
    func handleError(_ error: NSError)
}
