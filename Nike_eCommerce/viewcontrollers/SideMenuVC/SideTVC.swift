
import UIKit

class SideTVC: UITableViewCell {

    @IBOutlet weak var textLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setText(text: String) {
        textLbl.text = text
    }
    
}
