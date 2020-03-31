//
//  AddNewCardVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/9/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
import TextFieldEffects
class AddNewCardVC: UIViewController {

    @IBOutlet var txtFields: [HoshiTextField]!
    var isFilled: Bool = false
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
         title = "Add new card"
     }
     @objc func backPressed(){
            navigationController?.popViewController(animated: true)
        }


    @IBAction func addPressed(_ sender: UIButton) {
        for i in 0..<txtFields.count{
            if !txtFields[i].text!.isEmpty{
                isFilled = true
            }else{
                isFilled = false
            }
        }
        
        if  isFilled{
            let holderName =  txtFields[0].text!
            let cardNum = txtFields[1].text!
            let expireDate = txtFields[2].text!
            let cvv = txtFields[3].text!
            cardData.append(CardDM(holderName: holderName, cardNumber: cardNum, expireDate: expireDate, cvv: cvv))
            navigationController?.popViewController(animated: true)
            
            
        }else{
            let alert = UIAlertController(title: "Fill all fields", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert,animated: true)
        }
    }
    
}
