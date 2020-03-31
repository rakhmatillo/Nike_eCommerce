//
//  AddressCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/10/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
protocol EditAddressDelegate {
    func editAddressPresed(with id: Int)
}
protocol xButtonDelegate {
    func xButtonPressed(with id: Int)
}
class AddressCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    
    @IBOutlet weak var selectedImgView: UIImageView!
    var editAddressDelegate: EditAddressDelegate?
    var xButtonDelegate: xButtonDelegate?
    
    var id = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

 
    @IBAction func xPressed(_ sender: Any) {
        xButtonDelegate?.xButtonPressed(with: id)
    }
    
    @IBAction func editPressed(_ sender: Any) {
        editAddressDelegate?.editAddressPresed(with: id)
    }
}
