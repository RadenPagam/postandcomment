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
        tableView.delegate = self
        uName.text = "User Name: \(userName)"
        uEmail.text = "E-mail: \(userEmail)"
        uAdress.text = "Adress: \(userAdress)"
        uCompany.text = "Company: \(userCompany)"
        
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
        if album.count > 0 && photo.count > 0{
            return album.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        cell.albumTitle.text = album[indexPath.row].title
        let newUrl = "https://jsonplaceholder.typicode.com/albums/\(userId)/photos?title=\(album[indexPath.row].title)"
        cell.albumPhoto.downloaded(from:newUrl )
            return cell
    }
}

//MARK: - TableViewDelegate
extension UserViewController:UITableViewDelegate{
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

//MARK: - ImageVIew

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
