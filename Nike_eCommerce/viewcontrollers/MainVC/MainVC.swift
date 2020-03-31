//
//  MainVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 2/29/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIViewControllerTransitioningDelegate {

    var manData = ["Running shoes", "Basketball shoes", "Flip flops", "Football shoes"]
    var womanData = ["Basketball shoes", "Flip flops", "Football shoes", "Running shoes"]
    var kidsData = [ "Flip flops", "Running shoes", "Basketball shoes", "Football shoes"]
    var menu = SideMenuAnimation()

    @IBOutlet weak var tableView: UITableView!

    var navView: UIView!
    var tableHeaderView: UIView!
    var sectionNum = 0 //Man View = 0, Woman View = 1, Kids View = 2
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    //MARK: - Setup UI
    ///Initialiaze the UI
    func setupUI(){
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.ID_MAIN_TVC, bundle: nil), forCellReuseIdentifier: K.ID_MAIN_TVC)
        tableView.register(UINib(nibName: K.ID_HEADER_VIEW_IN_SECTION
            , bundle: nil), forHeaderFooterViewReuseIdentifier: K.ID_HEADER_VIEW_IN_SECTION)
        tableView.tableFooterView = UIView()
        
        setNavBar()
        
        //set tableHeader View
        tableHeaderView = UIView()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 6.5)
        
        
        //first title of Header view
        let lbl = UILabel()
        tableHeaderView.addSubview(lbl)
        lbl.text = "Discover your"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 10).isActive = true
        lbl.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 20).isActive = true
        lbl.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -20).isActive = true
        //second title of Header View
        let lbl1 = UILabel()
        tableHeaderView.addSubview(lbl1)
        lbl1.text = "Favourite footwear"
        lbl1.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lbl1.textColor = .black
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        lbl1.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 5).isActive = true
        lbl1.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 20).isActive = true
        lbl1.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -20).isActive = true
        
        //search Bar for Header view
        let searchBar = UISearchBar()
        tableHeaderView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search shoes..."
        searchBar.showsBookmarkButton = false
        
        searchBar.topAnchor.constraint(equalTo: lbl1.bottomAnchor, constant: 5).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -10).isActive = true
        searchBar.backgroundImage = UIImage()
        
        tableView.tableHeaderView = tableHeaderView
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
        
        tableView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0).isActive = true
        
        
        //Buttons for NavBar
        let menuButton = UIButton()
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(menuButton)
        menuButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
        menuButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 20).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        menuButton.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuTaped), for: .touchUpInside)
        
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
        
        let imgView = UIImageView(image: UIImage(named: "nike"))
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        navView.addSubview(imgView)
        imgView.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: navView.centerXAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        
    }
    
    
    
    //MARK: - Selector functions
    @objc func menuTaped(){
        let vc = SideMenuVC(nibName: "SideMenuVC", bundle: nil)
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .overFullScreen
        
        menu.delegate = vc.self
        vc.menuCellDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc func bookmarkTaped(){
     
    }
    @objc func bagTaped(){
       let vc = ShoppingBagVC(nibName: "ShoppingBagVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
           menu.isPresent = true
           return menu
       }
       
       func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
           menu.isPresent = false
           menu.baseView = self.view
           return menu
       }
    
}

//MARK: - TableView delegate extension
extension MainVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sectionNum == 0{
            return manData.count
            
        }else if sectionNum == 1{
            
           return womanData.count
        }else{
            
            return kidsData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_MAIN_TVC, for: indexPath) as? TVCell else  {return UITableViewCell()}
        cell.delegate = self
        cell.cellDelegate = self
        if sectionNum == 0{
            cell.selectionStyle = .none
            cell.titlelbl.text = manData[indexPath.row]
        }else if sectionNum == 1{
            cell.selectionStyle = .none
            cell.titlelbl.text = womanData[indexPath.row]
        }else{
            cell.selectionStyle = .none
            cell.titlelbl.text = kidsData[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = tableView.dequeueReusableHeaderFooterView(withIdentifier: K.ID_HEADER_VIEW_IN_SECTION) as! HeaderViewInSection
        v.delegate = self
        v.contentView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.view.frame.height / 18
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 2
    
    }
  
   
    
}

//MARK: - extension HeaderViewDelegate
extension MainVC: HeaderViewDelegate{
    func viewPressed(pressed tag: Int) {
        sectionNum = tag
        tableView.reloadData()
    }
    
    
}
//MARK: - See all Button delegate
extension MainVC: SeeAllDelegate{
    func seeAllPressed() {
        let vc = SeeAllVC(nibName: "SeeAllVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - extension Collection Cell delegate
extension MainVC: CollectionCellDelegate{
    func cellPressed(data: ProductDM) {
        let vc = DetailedProductVC(nibName: "DetailedProductVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainVC: MenuCellDelegate{
    func cellPressed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            let vc = CategoryVC(nibName: "CategoryVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
    }
    
    
}
