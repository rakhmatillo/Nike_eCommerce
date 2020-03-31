//
//  DetailedProductVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/7/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
import FloatRatingView
class DetailedProductVC: UIViewController {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var bookMarkBtn: UIButton!
    
    @IBOutlet weak var productNameLbl: UIStackView!
    
    @IBOutlet weak var ratingView: FloatRatingView!{
        didSet{
            ratingView.delegate = self
            ratingView.backgroundColor = UIColor.clear
            ratingView.contentMode = UIView.ContentMode.scaleAspectFit
            ratingView.type = .halfRatings
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupUI(){
        footerView.layer.cornerRadius = 20
        footerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    //MARK: - Add to bag Pressed
    @IBAction func addToBagPressed(_ sender: UIButton) {
    }
    
    //MARK: - back Pressed
    @IBAction func backPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - Rating Delegate
extension DetailedProductVC : FloatRatingViewDelegate{
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
    }
}
