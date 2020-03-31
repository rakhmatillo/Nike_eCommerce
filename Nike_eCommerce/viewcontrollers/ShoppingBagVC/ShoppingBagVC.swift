//
//  ShoppingBagVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/8/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
//MARK: - Address data
var addressData: [AddressDM] = [AddressDM(name: "TILLO", phoneNum: "998906319797", postCode: "151110", address: "MUSTAQILLIK 1", city: "Margilan", region: "Fergana", country: "Uzbekistan", isMain: true)]

//MARK: - All item in bag
 var itemsInBag = [ProductDM]()
class ShoppingBagVC: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: K.ID_SHOPPING_BAG_TVC, bundle: nil), forCellReuseIdentifier: K.ID_SHOPPING_BAG_TVC)
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: K.ID_ADDRESS_TVC, bundle: nil), forCellReuseIdentifier: K.ID_ADDRESS_TVC)
            tableView.register(UINib(nibName: K.ID_PRICE_DETAILS_TVC, bundle: nil), forCellReuseIdentifier: K.ID_PRICE_DETAILS_TVC)
            
        }
    }
 
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNumberOfItemsInBag()
        
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.navigationBar.hideBottomHairline()
        
       navigationItem.leftBarButtonItem = UIBarButtonItem(
        image: UIImage(named: "back")!.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(backPressed)
        )
        title = "Shopping Bag"
    }
    
    
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func checkNumberOfItemsInBag(){
        itemsInBag = []
        for i in 0..<productData.count {
            if productData[i].isInBag{
                itemsInBag.append(productData[i])
                
            }
        }
        
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        let vc = PaymentMethodVC(nibName: "PaymentMethodVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - Tableview delegate
extension ShoppingBagVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  
        
        return itemsInBag.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < itemsInBag.count{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_SHOPPING_BAG_TVC, for: indexPath) as? ShoppingBagTVCell else {return UITableViewCell()}
        cell.productLbl.text = itemsInBag[indexPath.row].productName
        cell.productImgView.image = itemsInBag[indexPath.row].productImg
        cell.productPriceLbl.text = itemsInBag[indexPath.row].productPrice
             return cell
        }else if indexPath.row == itemsInBag.count{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_ADDRESS_TVC, for: indexPath) as? AddressTVCell else {return UITableViewCell()}
            cell.delegate = self
            var address = ""
            if !addressData.isEmpty{
                for i in 0..<addressData.count where addressData[i].isMain{
                    address = addressData[i].address
                }
                cell.addressLbl.text = address
            }else{
                cell.addressLbl.text = "No addresses yet"
            }
             return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_PRICE_DETAILS_TVC, for: indexPath) as? PriceDetailTVCell else {return UITableViewCell()}
            
            var totalCost = 0
            for i in 0..<itemsInBag.count{
                let a = itemsInBag[i].productPrice.suffix(itemsInBag[i].productPrice.count - 1)
                let str = String(a)
                totalCost = totalCost + Int(str)!
            }
            cell.totalCostLbl.text = "\(totalCost)$"
            cell.count = itemsInBag.count
            return cell
        }
        
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == itemsInBag.count + 1 {
            return CGFloat(itemsInBag.count * 35 + 110)
        }
        if indexPath.row == itemsInBag.count{
            return CGFloat(100)
        }else{
            return CGFloat(self.view.frame.height / 5)

        }
    }
    
   
    
    
}

//MARK: - ChangeAddress Delegate
extension ShoppingBagVC: ChangeAddressDelegate{
    
    func addressChanged() {
        let vc = ShippingAddressVC(nibName: "ShippingAddressVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//to remove hairline in navigation bar
extension UIView {
    
    fileprivate var hairlineImageView: UIImageView? {
        return hairlineImageView(in: self)
    }
    
    fileprivate func hairlineImageView(in view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, imageView.bounds.height <= 1.0 {
            return imageView
        }
        
        for subview in view.subviews {
            if let imageView = self.hairlineImageView(in: subview) {
                return imageView
            }
        }
        return nil
    }
}

//to remove hairline in nav Bar
extension UINavigationBar {
    
    func hideBottomHairline() {
        self.hairlineImageView?.isHidden = true
    }
    
    func showBottomHairline() {
        self.hairlineImageView?.isHidden = false
    }
}



