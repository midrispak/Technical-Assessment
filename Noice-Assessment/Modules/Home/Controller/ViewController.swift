//
//  ViewController.swift
//  Noice-Assessment
//
//  Created by MacBook Pro on 16/02/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var commentInputField: UITextField!
    @IBOutlet weak var commentsTextview: UITextView!
    
    // MARK: - Properties
    var viewModel: TopicDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Fetch Comments and Load in TextView
        self.commentsTextview.text = "CLEARED"
        Service.shared.loadComments { items in
            if let items = items {
                let messages = items.map({ anItem in
                    anItem.message
                })
                
                let text = messages.reduce("") { partialResult, aComment in
                    partialResult + "\n" + aComment
                }
                self.commentsTextview.text = text
            }
        }
    }
    
    private func setupView() {
        viewModel = TopicDetailsViewModel()
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        if let text = commentInputField.text {
            commentsTextview.text = commentsTextview.text + "\n\n" + text
        }
        // Call API
    }
}

// For the comments failed to save on server
class OutBox {
    static let shared =  OutBox()
    var comments: [Comment]
    
    init() {
        comments = []
    }
    
    func saveInOutBox(_ comment: Comment) {
        comments.append(comment)
    }
    
    func serialize() {
        // Archive and save in user defaults
    }
    
    func syncWithServer() {
        // Unarchive and bring to memory
        // Call API
        
        comments.forEach { aComment in
            Service.shared.saveComment(aComment) { status in
                // Remove From OutBox
            }
        }
    }
}

let baseURL = "https://api.dev.noice.id"
let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InNpbV9rZXlfdjEifQ.eyJpZCI6IjQ5YjU0MWViLWJjNWUtNDkwOS05YTdiLTViMzMyOWNkMjNkMyIsInJvbGVzIjpbInVzZXIiXSwiaWF0IjoxNjQ0OTg5ODY0LCJleHAiOjE2NDQ5OTM0NjR9.psmCHwgqEeaehIfRDReey1iO9XhCyYuNTfPAKtP8ryE"

class Service {
    let url = "\(baseURL)/community-api/v1/post/e0000b7c-185f-4af0-9e3b-c1dcc6a22757?limit=10&page=1"
   
    static let shared = Service()
    
    func loadComments(_ completion: @escaping ( ([Datum]?) -> Void )) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            // CommentResponse
            if error == nil {
                // Success
                if let data = data {
                    let jsonObject = try! JSONDecoder().decode(CommentResponse.self, from: data)
                    
                    let comments = jsonObject.data
                    DispatchQueue.main.async {
                        completion(comments)
                    }
                }
            }
            else {
                // Failure
                // Save in OutBox
                // let failedComment = Comment()
                // OutBox.shared.saveInOutBox()
            }
            
        }.resume()
    }
    
    func saveComment(_ commentText: String, parentID: String = "e0000b7c-185f-4af0-9e3b-c1dcc6a22757", completion: ((Bool) -> Void) ) {
        
        let comment = Comment(message: commentText, parentID: parentID, type: .comment)
        
        saveComment(comment, completion: completion)
    }
    
    func saveComment(_ comment: Comment, completion: ((Bool) -> Void) ) {
        let url = "\(baseURL)/community-api/v1/post"
        var request = URLRequest(url: URL(string: url)!)
        let jsonData = try! JSONEncoder().encode(comment)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            // CommentResponse
            if error == nil {
                // Success
                if let data = data {
                    let jsonObject = try! JSONDecoder().decode(CommentResponse.self, from: data)
                }
            }
            else {
                // Failure
                // Save in OutBox
                // let failedComment = Comment()
                // OutBox.shared.saveInOutBox()
            }
            
        }.resume()
    }
}

