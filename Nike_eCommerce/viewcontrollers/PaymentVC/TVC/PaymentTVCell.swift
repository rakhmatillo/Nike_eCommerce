//
//  PaymentTVCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class PaymentTVCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var selectLbl: UILabel!
    
    @IBOutlet weak var checkmarkImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectLbl.isHidden = false
        checkmarkImgView.isHidden = true
        
    }

}
