//
//  DetailViewController.swift
//  postandcomment
//
//  Created by Dimas Pagam on 02/08/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var nameHolder:String = ""
    var titleHolder:String = ""
    var bodyHolder:String = ""
    var postid:Int = 0
    var userId:Int = 0
    var comment:[Comment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //tableView.delegate = self
        userName.text = " User: \(nameHolder)"
        postTitle.text = titleHolder
        postBody.text = bodyHolder
        
        let commentFunc = {
            (fetchCommentList:[Comment]) in
            DispatchQueue.main.async {
                self.comment = fetchCommentList
                self.tableView.reloadData()
            }
        }
        
        CommentApi.shared.fetchCommentList(postId: postid, onCompletion: commentFunc)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func userButtonPressed(_ sender: UIButton) {
        print("UserButton Pressed")
    }
    
}

//MARK: - TableviewDataSource
extension DetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        cell.commentUserName.text = "User: \(comment[indexPath.row].name)"
        cell.commentBody.text = comment[indexPath.row].body
        return cell
    }
    
    
}
