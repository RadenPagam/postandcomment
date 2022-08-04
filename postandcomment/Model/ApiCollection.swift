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

//MARK: - PhotoApi

final class PhotoApi{
    static let shared = PhotoApi()
    func fetchPhotoList(albumId:Int, onCompletion: @escaping ([Photo]) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) {( data, resp, error )in
            guard let data = data else{
                print("data nil")
                return
            }
            guard let photo = try? JSONDecoder().decode([Photo].self, from: data) else{
                print("couldn't decode user Json")
                return
            }
            onCompletion(photo.self)
        }
        task.resume()
    }
}

struct Photo:Codable,Equatable{
    let albumId:Int
    let id:Int
    let title:String
    let url:String
    let thumbnailUrl:String
}
//MARK: - ALBUMAPI
final class AlbumApi{
    static let shared = AlbumApi()
    
    func fetchAlbumList(userId:Int, onCompletion: @escaping ([Album]) -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/albums?userId=\(userId)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) {( data, resp, error )in
            guard let data = data else{
                print("data nil")
                return
            }
            guard let album = try? JSONDecoder().decode([Album].self, from: data) else{
                print("couldn't decode user Json")
                return
            }
            onCompletion(album.self)
        }
        task.resume()
    }
}

struct Album:Codable{
    let userId:Int
    let id:Int
    let title:String
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
        let urlString = "https://jsonplaceholder.typicode.com/users/\(userId)"
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

