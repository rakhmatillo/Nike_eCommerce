//
//  FilterVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 3/7/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {
    var leftListData = ["Price", "Size", "Offers", "Discount", "Colour", "Rating", "Material"]
    
    var data1: [[String]] = [
        [""],
        ["2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6"],
        ["10% above", "20% above", "30% above", "50% above"],
        ["2+ rating","3+ rating", "4+ rating", "5+ rating"],
        ["2+ rating","3+ rating", "4+ rating", "5+ rating"],
        ["2+ rating","3+ rating", "4+ rating", "5+ rating"],
        ["2+ rating","3+ rating", "4+ rating", "5+ rating"]]
    
    @IBOutlet weak var tableView1: UITableView!{
        didSet{
            tableView1.delegate = self
            tableView1.dataSource = self
            tableView1.tableFooterView = UIView()
            
        }
    }
    
    
    @IBOutlet weak var tableView2: UITableView!{
        didSet{
            tableView2.delegate = self
            tableView2.dataSource = self
            tableView2.tableFooterView = UIView()
            tableView2.register(UINib(nibName: K.ID_FILTER_PRICE_TVC, bundle: nil), forCellReuseIdentifier: K.ID_FILTER_PRICE_TVC)
        }
    }
    
    var choosenFilter = 0
    let clearBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearBtn.setTitle("Clear all", for: .normal)
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(clearBtn)
        clearBtn.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: .normal)
        clearBtn.addTarget(self, action: #selector(clearBtnPressed), for: .touchUpInside)
        
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearBtn.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -5),
            clearBtn.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -12),
            clearBtn.heightAnchor.constraint(equalToConstant: 30),
            clearBtn.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
   
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        clearBtn.removeFromSuperview()
        
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
        title = "Filter"
        
    }
    
    @objc func backPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func clearBtnPressed() {
        tableView2.reloadData()
    }
    
    
    
    @IBAction func applyBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension FilterVC: UITableViewDelegate, UITableViewDataSource{
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return leftListData.count
        }else{
            if choosenFilter == 0{
                return 1
            }else{
                return data1[choosenFilter].count
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if tableView == tableView1{
            cell.textLabel?.text = leftListData[indexPath.row]
            cell.textLabel?.textColor = #colorLiteral(red: 0.1568627451, green: 0.1725490196, blue: 0.2509803922, alpha: 1)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            if indexPath.row == choosenFilter{
                cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                cell.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            }
        }else{
            if choosenFilter == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: K.ID_FILTER_PRICE_TVC, for: indexPath) as? FilterPriceTVCell else {return UITableViewCell()}
                return cell
                
            }else{
                cell.textLabel?.text = data1[choosenFilter][indexPath.row]
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = #colorLiteral(red: 0.1568627451, green: 0.1725490196, blue: 0.2509803922, alpha: 1)
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.selectionStyle = .none
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableView1{
            return 80
        }else{
            if choosenFilter == 0{
                return 100
            }else{
                return 50
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView1 {
            choosenFilter = indexPath.row
            tableView1.reloadData()
            tableView2.reloadData()
        }else if tableView == tableView2 && choosenFilter != 0{
            
            let cell = tableView2.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            cell?.textLabel?.textColor = .systemBlue
        }
        
        
    }
    
    
}

