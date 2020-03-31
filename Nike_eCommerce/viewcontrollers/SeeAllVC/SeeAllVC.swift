//
//  SeeAllVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/6/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class SeeAllVC: UIViewController {
    
    var navView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: K.ID_MAIN_CVC, bundle: nil), forCellWithReuseIdentifier: K.ID_MAIN_CVC)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setNavBar()
    }
    //MARK: - Set Custom Navigation Bar
    ///Sets Custom NavigationBar
    func setNavBar(){
        
        navView = UIView()
        self.view.addSubview(navView)
        navView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        navView.translatesAutoresizingMaskIntoConstraints = false
        navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 16).isActive = true
        navView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        navView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        
        //Buttons for NavBar
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(backButton)
        backButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        backButton.setImage(#imageLiteral(resourceName: "backChevron"), for: .normal)
        backButton.setBackgroundImage(#imageLiteral(resourceName: "backChevron"), for: .normal)
        backButton.addTarget(self, action: #selector(backTaped), for: .touchUpInside)
        
        let bookmark = UIButton()
        bookmark.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bookmark)
        bookmark.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
        bookmark.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -60).isActive = true
        bookmark.heightAnchor.constraint(equalToConstant: 20).isActive = true
        bookmark.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bookmark.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        bookmark.addTarget(self, action: #selector(bookmarkTaped), for: .touchUpInside)
        
        
        let bag = UIButton()
        bag.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(bag)
        bag.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
        bag.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -15).isActive = true
        bag.heightAnchor.constraint(equalToConstant: 20).isActive = true
        bag.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        bag.setImage(#imageLiteral(resourceName: "bag"), for: .normal)
        
        bag.addTarget(self, action: #selector(bagTaped), for: .touchUpInside)
        
        
        
        
    }
    
    //MARK: - Selector functions
    @objc func backTaped(){
        navigationController?.popViewController(animated: true)
    }
    @objc func bookmarkTaped(){
        
    }
    @objc func bagTaped(){
        
    }
    
}

extension SeeAllVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height / 2)
    }
    
    
}

//MARK: - extension of Protocols
extension SeeAllVC: ProductSavedDelegate, ProductInBagDelegate{
    func bagPressed(cellPosition: Int) {
        
        productData[cellPosition].isInBag = !productData[cellPosition].isInBag
        collectionView.reloadData()
        
    }
    
    
    func savePressed(cellPosition: Int) {
        
        productData[cellPosition].isSaved = !productData[cellPosition].isSaved
        collectionView.reloadData()
        
        
    }
    
    
}

