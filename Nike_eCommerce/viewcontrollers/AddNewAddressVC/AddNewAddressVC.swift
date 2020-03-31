//
//  AddNewAddressVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/11/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
import TextFieldEffects

class AddNewAddressVC: UIViewController {
    var isEditPressed = false
    var data = AddressDM()
    @IBOutlet var txtFields: [HoshiTextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEditPressed{
            title = "Edit Address"
           txtFields[0].text = data.name
           txtFields[1].text = data.phoneNum
           txtFields[2].text = data.postCode
           txtFields[3].text = data.address
           txtFields[4].text = data.city
           txtFields[5].text = data.region
           txtFields[6].text = data.country
        }else{
            for i in 0..<txtFields.count{
                title = "Add Address"
                txtFields[i].text = ""
            }
        }
       
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
         
     }
     @objc func backPressed(){
            navigationController?.popViewController(animated: true)
        }

    
    @IBAction func savePressed(_ sender: UIButton) {
        var newaddress = AddressDM()
        newaddress.name = txtFields[0].text
       newaddress.phoneNum = txtFields[1].text
        newaddress.postCode = txtFields[2].text
        newaddress.address = txtFields[3].text!
        newaddress.city = txtFields[4].text
        newaddress.region = txtFields[5].text
        newaddress.country = txtFields[6].text
        
        addressData.append(newaddress)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
   

}
