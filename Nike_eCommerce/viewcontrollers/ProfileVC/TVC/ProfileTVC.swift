

import UIKit

class ProfileTVC: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var rightBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switcher.isHidden = true
        
    }

}
