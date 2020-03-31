//
//  PayWithCardVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

var cardData = [CardDM(holderName: "Rakhmatillo", cardNumber: "1234123412349876", expireDate: "10/22", cvv: "911")]

class PayWithCardVC: UIViewController {
    
    @IBOutlet weak var orderPlacedImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: K.ID_CARDVIEW_TVC, bundle: nil), forCellReuseIdentifier: K.ID_CARDVIEW_TVC)
            tableView.register(UINib(nibName: K.ID_ADD_CARD_TVC, bundle: nil), forCellReuseIdentifier: K.ID_ADD_CARD_TVC)
            tableView.register(UINib(nibName: K.ID_PRICE_DETAILS_TVC, bundle: nil), forCellReuseIdentifier: K.ID_PRICE_DETAILS_TVC)
            
        }
        
    }
    
    @IBOutlet weak var payBtn: UIButton!
    var totalCost = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        orderPlacedImageView.isHidden = true
        calculateTotalCost()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.hideBottomHairline()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "back")!.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(backPressed)
        )
        title = "Payment methods"
    }
    @objc func backPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Calculate Cost
    func calculateTotalCost(){
        
        for i in 0..<itemsInBag.count{
            let a = itemsInBag[i].productPrice.suffix(itemsInBag[i].productPrice.count - 1)
            let str = String(a)
            totalCost = totalCost + Int(str)!
        }
        
    }
    
    //MARK: - Pay Button
    @IBAction func payBtnPressed(_ sender: UIButton) {
        //MARK: - ORDER PLACED IMAGE SHOULD APPEAR
        let alert = UIAlertController(title: "YOUR ORDER PLACED", message: "Estimated delivery 10 days", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)

    }
    
}

extension PayWithCardVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return cardData.count + 1
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        payBtn.setTitle("PAY $\(totalCost)", for: .normal)
        if indexPath.section == 0{
            if !cardData.isEmpty && indexPath.row < cardData.count{
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_CARDVIEW_TVC, for: indexPath) as? CardViewCell else {return UITableViewCell()}
                
                cell.holderNameLbl.text = cardData[indexPath.row].holderName
                cell.expireLbl.text = cardData[indexPath.row].expireDate
                cell.cvvLbl.text = cardData[indexPath.row].cvv
                cell.lastFourDigitLbl.text = String(cardData[indexPath.row].cardNumber.suffix(4))
                
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_ADD_CARD_TVC, for: indexPath) as? AddCardBtnCell else {return UITableViewCell()}
                cell.delegate = self
                return cell
            }
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_PRICE_DETAILS_TVC, for: indexPath) as? PriceDetailTVCell else {return UITableViewCell()}
            
            cell.totalCostLbl.text = "$\(totalCost)"
            cell.count = itemsInBag.count
            return cell
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if indexPath.row == cardData.count{
                return 60
            }else{
                return self.view.frame.height / 3.5
            }
        }else{
            return CGFloat(itemsInBag.count * 35 + 110)
        }
    }
    
}

extension PayWithCardVC: AddCardDelegate{
    func addPressed() {
        print("hi")
        let vc = AddNewCardVC(nibName: "AddNewCardVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
