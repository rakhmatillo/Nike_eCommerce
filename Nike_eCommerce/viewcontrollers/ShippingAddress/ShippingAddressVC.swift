//
//  ShippingAddressVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/10/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class ShippingAddressVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")
            tableView.register(UINib(nibName: K.ID_ADD_CARD_TVC, bundle: nil), forCellReuseIdentifier: K.ID_ADD_CARD_TVC)
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
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
         title = "Shipping Address"
        tableView.reloadData()
     }
     @objc func backPressed(){
            navigationController?.popViewController(animated: true)
        }

    @IBAction func continueBtnPressed(_ sender: UIButton) {
        
    }
    

}

extension ShippingAddressVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !(indexPath.row == addressData.count){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell else {return UITableViewCell()}
            cell.xButtonDelegate = self
            cell.editAddressDelegate = self
            cell.id = indexPath.row
//            addressData[indexPath.row].id = indexPath.row
            cell.Name.text = addressData[indexPath.row].name!
            cell.streetLbl.text = addressData[indexPath.row].address
            cell.cityLbl.text = addressData[indexPath.row].city!
            cell.regionLbl.text = addressData[indexPath.row].region!
            cell.countryLbl.text = addressData[indexPath.row].country
            cell.phoneNum.text = addressData[indexPath.row].phoneNum
            if addressData[indexPath.row].isMain{
                cell.selectedImgView.image = #imageLiteral(resourceName: "selected")
            }else{
                cell.selectedImgView.image = nil

            }
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_ADD_CARD_TVC, for: indexPath) as? AddCardBtnCell else {
                return UITableViewCell()
            }
            print("hi")
            cell.delegate = self
            cell.btn.setTitle("+Add address", for: .normal)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !(indexPath.row == addressData.count){
            return tableView.frame.height / 3
        }else{
            return 60
        }
    }
    
}

extension ShippingAddressVC: AddCardDelegate{
    func addPressed() {
        let vc = AddNewAddressVC(nibName: "AddNewAddressVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ShippingAddressVC: EditAddressDelegate, xButtonDelegate{
    
    func editAddressPresed(with id: Int) {
        if !addressData.isEmpty{
            let vc = AddNewAddressVC(nibName: "AddNewAddressVC", bundle: nil)
            vc.isEditPressed = true
            vc.data = addressData[id]
            navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
    
    func xButtonPressed(with id: Int) {
        print(id)
        addressData.remove(at: 0)
        tableView.reloadData()
    }
    
    
    
    
}
