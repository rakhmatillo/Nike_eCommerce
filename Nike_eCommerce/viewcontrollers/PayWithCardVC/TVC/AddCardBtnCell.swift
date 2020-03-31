//
//  AddCardBtnCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/9/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
protocol AddCardDelegate {
    func addPressed()
}

class AddCardBtnCell: UITableViewCell {
    var delegate: AddCardDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var btn: UIButton!
    
    @IBAction func pressed(_ sender: UIButton) {
        delegate?.addPressed()
    }
    
}
