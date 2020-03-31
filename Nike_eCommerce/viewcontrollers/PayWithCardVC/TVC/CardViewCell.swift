//
//  CardViewCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class CardViewCell: UITableViewCell {
    @IBOutlet weak var holderNameLbl: UILabel!
       @IBOutlet weak var expireLbl: UILabel!
       @IBOutlet weak var cvvLbl: UILabel!
       @IBOutlet weak var lastFourDigitLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
