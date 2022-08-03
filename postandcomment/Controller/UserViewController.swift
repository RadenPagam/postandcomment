//
//  UserViewController.swift
//  postandcomment
//
//  Created by Dimas Pagam on 03/08/22.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var uEmail: UILabel!
    @IBOutlet weak var uAdress: UILabel!
    @IBOutlet weak var uCompany: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var userName:String = ""
    var userEmail:String = ""
    var userAdress:String = ""
    var userCompany:String = ""
    var userId:Int = 0
    
    var album:[Album] = []
    var photo:[Photo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.bounces = false
        uName.text = userName
        uEmail.text = userEmail
        uAdress.text = userAdress
        uCompany.text = userCompany
        
        let albumFunc = {
            (fetchAlbum:[Album]) in
            DispatchQueue.main.async {
                self.album = fetchAlbum
                self.tableView.reloadData()
            }
        }
        
        AlbumApi.shared.fetchAlbumList(userId: userId, onCompletion: albumFunc)
        
        let photoFunc = {
            (fetchPhoto:[Photo]) in
            DispatchQueue.main.async {
                self.photo = fetchPhoto
                self.tableView.reloadData()
            }
        }
        
        
        PhotoApi.shared.fetchPhotoList(albumId: userId , onCompletion: photoFunc)
    }
}

//MARK: - TableViewDataSource
extension UserViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        
        cell.textLabel?.text = album[indexPath.row].title
        print("\(album[indexPath.row].id)")
        return cell
    }
    
    
}
