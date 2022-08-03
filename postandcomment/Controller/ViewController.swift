//
//  ViewController.swift
//  postandcomment
//
//  Created by Dimas Pagam on 02/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var post:[Post] = []
    var user:[User] = []
    var nameHolder:String = ""
    var titleHolder:String = ""
    var bodyHolder:String = ""
    var postIDHolder:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        let postFunc = {
            (fetchedPostList:[Post]) in
            DispatchQueue.main.async {
                self.post = fetchedPostList
                self.tableView.reloadData()
            }
        }
        PostApi.shared.fetchPostList(onCompletion: postFunc)
        
        let userFunc = {
            (fetchUserList:[User]) in
            DispatchQueue.main.async {
                self.user = fetchUserList
                self.tableView.reloadData()
            }
        }
        UserApi.shared.fetchUserList(onCompletion: userFunc)
    }
    
    func checkIndex(index:Int)->Int{
        var val = index
        if index / 10 > 10{
            val = 10
        }
        return val
    }
}


// MARK: - UiTableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("total post: \(post.count)")
        if user.count > 0 && post.count > 0{
            return post.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! postTableViewCell
        print("index path \(indexPath.row) | user \(user[indexPath.row / 10].id)")
        _ = indexPath.row
        let name = user[indexPath.row / 10].username
        let company = user[indexPath.row / 10].company.name
        let title = post[indexPath.row].title
        let body = post[indexPath.row].body
        
        cell.postTitle.text = title
        cell.postBody.text = body
        cell.userNameCompany.text =  "\(name) | \(company)"
        
        return cell
        
    }
    
    
}

// MARK: - UiTableViewDelegate
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ID: \(indexPath.row + 1)")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detailView") as? DetailViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.bodyHolder = post[indexPath.row].body
            vc.titleHolder = post[indexPath.row].title
            vc.nameHolder =  user[indexPath.row / 10].username
            vc.postid = indexPath.row + 1
            vc.userId = user[indexPath.row / 10].id
        
        }
    }
}
