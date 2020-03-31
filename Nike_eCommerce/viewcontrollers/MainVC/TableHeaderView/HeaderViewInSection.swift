//
//  HeaderViewInSection.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/5/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
protocol HeaderViewDelegate {
    func viewPressed(pressed tag: Int)
}

class HeaderViewInSection: UITableViewHeaderFooterView {
    
    @IBOutlet var lbls: [UILabel]!
    
    @IBOutlet var views: [UIView]!
    
    var delegate : HeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0..<lbls.count{
            if i == 0{
                lbls[i].textColor = #colorLiteral(red: 0.3411764706, green: 0.5019607843, blue: 0.8509803922, alpha: 1)
                lbls[i].font = UIFont.systemFont(ofSize: 17, weight: .bold)
                views[i].isHidden = false
            }else{
                lbls[i].textColor = .lightGray
                lbls[i].font = UIFont.systemFont(ofSize: 17, weight: .regular)
                views[i].isHidden = true
            }
        }
    }
    
    @IBAction func pressed(_ sender: UIButton) {
        print(sender.tag)
        
        
        for i in 0..<lbls.count{
            if i == sender.tag{
                lbls[i].textColor = #colorLiteral(red: 0.3411764706, green: 0.5019607843, blue: 0.8509803922, alpha: 1)
                lbls[i].font = UIFont.systemFont(ofSize: 17, weight: .bold)
                views[i].isHidden = false
            }else{
                lbls[i].textColor = .lightGray
                lbls[i].font = UIFont.systemFont(ofSize: 17, weight: .regular)
                views[i].isHidden = true
            }
            
        }
        delegate?.viewPressed(pressed: sender.tag)
        
        
    }
    
    
}
