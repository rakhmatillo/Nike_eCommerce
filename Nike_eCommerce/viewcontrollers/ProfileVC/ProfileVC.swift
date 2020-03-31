

import UIKit

struct ProfileSection{
    var name: String
    var icon: UIImage
}

class ProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [ProfileSection] = [
        ProfileSection(name: "My orders", icon: #imageLiteral(resourceName: "myorders")),
        ProfileSection(name: "My cards & wallets", icon: #imageLiteral(resourceName: "mycards")),
        ProfileSection(name: "Address", icon: #imageLiteral(resourceName: "address")),
        ProfileSection(name: "Notifications", icon: #imageLiteral(resourceName: "notifications")),
        ProfileSection(name: "Wishlist", icon: #imageLiteral(resourceName: "wishlist")),
        ProfileSection(name: "Profile", icon: #imageLiteral(resourceName: "profileicon")),
        ProfileSection(name: "Log out", icon: #imageLiteral(resourceName: "logouticon"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "ProfileTVC", bundle: nil), forCellReuseIdentifier: "ProfileTVC")
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVC", for: indexPath) as? ProfileTVC else{
            return UITableViewCell()
        }
     
        
        cell.line.isHidden = false
        cell.name.text = data[indexPath.row].name
        cell.icon.image = data[indexPath.row].icon
        
        if indexPath.row == 3{
            cell.switcher.isHidden = false
            cell.rightBtn.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
