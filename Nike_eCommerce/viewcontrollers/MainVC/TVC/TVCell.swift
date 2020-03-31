//
//  TVCell.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/3/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
protocol SeeAllDelegate {
    func seeAllPressed()
}


protocol CollectionCellDelegate {
    func cellPressed(data: ProductDM)
}

//MARK: - Initializing product data
var productData : [ProductDM] = [ProductDM(isSaved: false, productImg: #imageLiteral(resourceName: "product1"), productName: "Nike Air Max", productPrice: "$45", productDesc: "The Nike GTX shoe borrows design lines from The heritage runners the Nike React tech.", isInBag: false), ProductDM(isSaved: true, productImg: #imageLiteral(resourceName: "product2"), productName: "Nike Air Max1", productPrice:"$32", productDesc: "The Nike GTX shoe borrows design lines from The heritage runners the Nike React tech.", isInBag: false), ProductDM(isSaved: false, productImg: #imageLiteral(resourceName: "product8"), productName: "Nike Water Max", productPrice: "$20", productDesc: "The Nike GTX shoe borrows design lines from The heritage runners the Nike React tech.", isInBag: false)]


class TVCell: UITableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    var delegate: SeeAllDelegate?
    var cellDelegate: CollectionCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: K.ID_MAIN_CVC, bundle: nil), forCellWithReuseIdentifier: K.ID_MAIN_CVC)
        
    }
    
    
    //MARK: - See all button pressed
    @IBAction func seeAllPressed(_ sender: UIButton) {
        delegate?.seeAllPressed()
  
        
    }
    
    
}
//MARK: - Extension for collection view
extension TVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        return CGSize(width: collectionView.frame.width / 1.7, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellDelegate?.cellPressed(data: productData[indexPath.item])
        
    }
    
    
}

//MARK: - extension Protocols
extension TVCell: ProductSavedDelegate, ProductInBagDelegate{
    
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

