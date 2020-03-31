//
//  PaymentMethodVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
var paymentMethod = [PaymentMethodDM(methodOfPay: "Credit/Debit Card", isSelected: false), PaymentMethodDM(methodOfPay: "Netbanking", isSelected: false), PaymentMethodDM(methodOfPay: "Cashon delivery", isSelected: false), PaymentMethodDM(methodOfPay: "Google pay", isSelected: false), PaymentMethodDM(methodOfPay: "Paytm/Wallets", isSelected: false)]

class PaymentMethodVC: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: K.ID_PAYMENT_TVC, bundle: nil), forCellReuseIdentifier: K.ID_PAYMENT_TVC)
            tableView.register(UINib(nibName: K.ID_PRICE_DETAILS_TVC, bundle: nil), forCellReuseIdentifier: K.ID_PRICE_DETAILS_TVC)
        }
    }
    var totalCost = 0
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateTotalCost()
        continueBtn.alpha = 0.5
        continueBtn.setTitle("PAY $\(totalCost)", for: .normal)
    }
    @objc func backPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        let vc = PayWithCardVC(nibName: "PayWithCardVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    func calculateTotalCost(){
        
        for i in 0..<itemsInBag.count{
            let a = itemsInBag[i].productPrice.suffix(itemsInBag[i].productPrice.count - 1)
            let str = String(a)
            totalCost = totalCost + Int(str)!
        }
        
    }
    
}
extension PaymentMethodVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return paymentMethod.count
            
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_PAYMENT_TVC, for: indexPath) as? PaymentTVCell else {return UITableViewCell()}
            cell.lbl.text = paymentMethod[indexPath.row].methodOfPay
            if paymentMethod[indexPath.row].isSelected{
                cell.backView.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.4745098039, blue: 0.8431372549, alpha: 1)
                cell.lbl.textColor = .white
                cell.selectLbl.isHidden = true
                cell.checkmarkImgView.isHidden = false
                
            }else{
                cell.backView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.selectLbl.isHidden = false
                cell.lbl.textColor = #colorLiteral(red: 0.4117647059, green: 0.4235294118, blue: 0.4745098039, alpha: 1)
                cell.checkmarkImgView.isHidden = true
                
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_PRICE_DETAILS_TVC, for: indexPath) as? PriceDetailTVCell else {return UITableViewCell()}
            
            cell.totalCostLbl.text = "$\(totalCost)"
            cell.count = itemsInBag.count
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<paymentMethod.count{
            paymentMethod[i].isSelected = false
        }
        if indexPath.section == 0{
            paymentMethod[indexPath.row].isSelected = !paymentMethod[indexPath.row].isSelected
        }
        continueBtn.alpha = 1
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return CGFloat(itemsInBag.count * 35 + 110)
        }else{
            return CGFloat(60)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
