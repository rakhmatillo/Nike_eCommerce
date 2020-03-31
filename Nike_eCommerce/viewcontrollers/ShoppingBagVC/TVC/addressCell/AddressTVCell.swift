//
//  AddressTVCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

protocol ChangeAddressDelegate {
    func addressChanged()
}


class AddressTVCell: UITableViewCell {
    @IBOutlet weak var addressLbl: UILabel!
    var delegate: ChangeAddressDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func changeAddressPressed(_ sender: UIButton) {
        delegate?.addressChanged()
    }
}
