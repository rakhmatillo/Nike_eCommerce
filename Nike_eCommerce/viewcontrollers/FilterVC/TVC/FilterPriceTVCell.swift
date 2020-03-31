//
//  FilterPriceTVCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/9/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
import WARangeSlider
class FilterPriceTVCell: UITableViewCell {

    @IBOutlet weak var rangeView: RangeSlider!
    @IBOutlet weak var rangeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rangeLbl.text = "$\(Int(rangeView.lowerValue)) - $\(Int(rangeView.upperValue))"
        
    }

    @IBAction func valueChanged(_ sender: RangeSlider) {
        rangeLbl.text = "$\(Int(rangeView.lowerValue)) - $\(Int(rangeView.upperValue))"
    }
    
}
