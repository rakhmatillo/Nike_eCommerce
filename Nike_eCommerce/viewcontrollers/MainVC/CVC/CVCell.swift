//
//  CVCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/5/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

protocol ProductSavedDelegate {
    func savePressed(cellPosition: Int)
}

protocol ProductInBagDelegate {
    func bagPressed(cellPosition: Int)
}

class CVCell: UICollectionViewCell {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var productImgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bagImg: UIImageView!
    @IBOutlet weak var bagBackView: UIView!
    
    var cellPosition = 0
    var isSavePressed = false
    var isInBagPressed = false
    
    var saveDelegate : ProductSavedDelegate?
    var bagDelegate : ProductInBagDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bagImg.image = #imageLiteral(resourceName: "bag").withRenderingMode(.alwaysTemplate)
        
        bagImg.tintColor = .white
        bagBackView.layer.cornerRadius = 15
        bagBackView.layer.maskedCorners = [.layerMinXMinYCorner]
        bagBackView.alpha = 0.2
        
        
        
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        saveDelegate?.savePressed(cellPosition: cellPosition)
    
    }
    
    @IBAction func bagBtnPressed(_ sender: UIButton) {
        bagDelegate?.bagPressed(cellPosition: cellPosition)
    }
    
}
