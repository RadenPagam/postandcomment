//
//  ApiCollection.swift
//  postandcomment
//
//  Created by Dimas Pagam on 02/08/22.
//

import Foundation

//MARK: - PostApi
final class PostApi{
    static let shared = PostApi()
    func fetchPostList(onCompletion: @escaping ([Post]) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) {( data, resp, error )in
            guard let data = data else{
                print("data nil")
                return
            }
            guard let post = try? JSONDecoder().decode([Post].self, from: data) else{
                print("couldn't decode user Json")
                return
            }
            onCompletion(post.self)
        }
        task.resume()
    }
}

struct Post:Codable{
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

//MARK: - CommentAPI
final class CommentApi{
    static let shared = CommentApi()
    func fetchCommentList(postId:Int,onCompletion: @escaping ([Comment]) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(postId)/comments"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) {( data, resp, error )in
            guard let data = data else{
                print("data nil")
                return
            }
            guard let comment = try? JSONDecoder().decode([Comment].self, from: data) else{
                print("couldn't decode user Json")
                return
            }
            onCompletion(comment.self)
        }
        task.resume()
    }
}

struct Comment:Codable{
    let postId:Int
    let id:Int
    let name:String
    let email:String
    let body:String
}
// MARK: - UserAPI
final class UserApi{
    static let shared = UserApi()
    func fetchUserList(onCompletion: @escaping ([User]) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error )in
            
            guard let data = data else{
                print("Data nil")
                return
            }
            guard let user = try? JSONDecoder().decode([User].self, from: data) else{
                print("couldn't decode user Json")
                return
            }
            onCompletion(user.self)
            
        }
        
        task.resume()
    }
    
    func fetchUserid(userId:Int,onCompletion: @escaping ([User]) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/posts/\(userId)/users"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error )in
            
            guard let data = data else{
                print("Data nil")
                return
            }
            guard let user = try? JSONDecoder().decode([User].self, from: data) else{
                print("couldn't decode user Json")
                return
            }
            onCompletion(user.self)
            
        }
        
        task.resume()
    }
}
struct User:Codable{
    let id: Int
        let name, username, email: String
        let address: Address
        let phone, website: String
        let company: Company
}

struct Address:Codable{
    let street, suite, city, zipcode: String
        let geo: Geo
}

struct Geo:Codable{
    let lat, lng: String
}

struct Company:Codable{
    let name, catchPhrase, bs: String
}
/*
 {
     "id": 1,
     "name": "Leanne Graham",
     "username": "Bret",
     "email": "Sincere@april.biz",
     "address": {
       "street": "Kulas Light",
       "suite": "Apt. 556",
       "city": "Gwenborough",
       "zipcode": "92998-3874",
       "geo": {
         "lat": "-37.3159",
         "lng": "81.1496"
       }
     },
     "phone": "1-770-736-8031 x56442",
     "website": "hildegard.org",
     "company": {
       "name": "Romaguera-Crona",
       "catchPhrase": "Multi-layered client-server neural-net",
       "bs": "harness real-time e-markets"
     }
   }
 */
