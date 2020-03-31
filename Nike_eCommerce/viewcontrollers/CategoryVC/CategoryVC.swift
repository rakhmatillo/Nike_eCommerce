//
//  CategoryVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/9/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: K.ID_MAIN_CVC, bundle: nil), forCellWithReuseIdentifier: K.ID_MAIN_CVC)
        }
    }
    
    var cellDelegate: CollectionCellDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }

    @IBAction func filterPressed(_ sender: UIButton) {
        let vc = FilterVC(nibName: "FilterVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - CollectionView delegate
extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        productData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ID_MAIN_CVC, for: indexPath) as? CVCell else {return UICollectionViewCell()}
        cell.saveDelegate = self
        cell.bagDelegate = self
        cell.cellPosition = indexPath.item
        cell.nameLbl.text = productData[indexPath.item].productName
        cell.priceLbl.text = productData[indexPath.item].productPrice
        cell.productImgView.image = productData[indexPath.item].productImg
        if productData[indexPath.item].isSaved{
            cell.saveBtn.setImage(#imageLiteral(resourceName: "bookmark.fill"), for: .normal)
        }else{
            cell.saveBtn.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
        if productData[indexPath.item].isInBag{
            cell.bagBackView.alpha = 1
        }else{
            cell.bagBackView.alpha = 0.2
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width  / 2, height: collectionView.frame.height / 2)
    }
    
    
}

//MARK: - extension Protocols
extension CategoryVC: ProductSavedDelegate, ProductInBagDelegate{
    
    func bagPressed(cellPosition: Int) {
        
        productData[cellPosition].isInBag = !productData[cellPosition].isInBag
        print(productData)

        collectionView.reloadData()
       
    }
    
    
    func savePressed(cellPosition: Int) {
        productData[cellPosition].isSaved = !productData[cellPosition].isSaved
        collectionView.reloadData()
        
        
    }
    
    
}
