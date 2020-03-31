//
//  ShoppingBagTVCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class ShoppingBagTVCell: UITableViewCell {
    
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    
    var count = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        countLbl.text = "\(count)"
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        if !(count <= 0) {
            count -= 1
            countLbl.text = "\(count)"
        }
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        if count < 21{
            count += 1
            countLbl.text = "\(count)"
        }
    }
}
