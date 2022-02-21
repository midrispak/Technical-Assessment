//
//  TopicDetailsViewModel.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 21/02/2022.
//

import Foundation
import Combine

class TopicDetailsViewModel {
    @Published var comments: [Datum]
    
    init() {
        comments = []
    }
    
    func loadComments() {
        comments = []
    }
}
