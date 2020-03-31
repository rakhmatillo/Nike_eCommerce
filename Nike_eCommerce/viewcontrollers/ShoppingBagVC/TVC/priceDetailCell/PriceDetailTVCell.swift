//
//  PriceDetailTVCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class PriceDetailTVCell: UITableViewCell {
    @IBOutlet weak var tableView: UITableView! {
           didSet {
               tableView.delegate = self
               tableView.dataSource = self
               tableView.separatorStyle = .none
               tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: K.ID_ITEM_CELL_TVC, bundle: nil), forCellReuseIdentifier: K.ID_ITEM_CELL_TVC)
           }
       }
       
    @IBOutlet weak var totalCostLbl: UILabel!
    
    var count: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension PriceDetailTVCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_ITEM_CELL_TVC, for: indexPath) as? ItemCell else {return UITableViewCell()}
        cell.itemNameLbl.text = itemsInBag[indexPath.row].productName
        cell.itemPriceLbl.text = itemsInBag[indexPath.row].productPrice
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    
    
}
