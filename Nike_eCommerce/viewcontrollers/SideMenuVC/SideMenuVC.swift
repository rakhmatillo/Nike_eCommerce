


import UIKit
protocol MenuCellDelegate {
    func cellPressed()
}
class SideMenuVC: UIViewController, MenuAnimationProtocol {
    
    func gestureTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let headerImages = [UIImage(named: "men"), UIImage(named: "women"), UIImage(named: "kids")]
    let headerNames = ["Men", "Women", "Kids"]
    let cellNames = [["Casual Shoes", "Sports shoes", "Flipflops", "Sandals", "Floaters"], ["Casual Shoes", "Sports shoes", "Flipflops", "Sandals"], ["Casual Shoes", "Sports shoes", "Flipflops", "Sandals", "Floaters"]]
    
    var sectionIsOpen = [false, false, false]
    
    var menuCellDelegate: MenuCellDelegate?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "SideTVC", bundle: nil), forCellReuseIdentifier: "SideTVC")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @objc func headerPressed(button: UIButton) {
        sectionIsOpen[button.tag] = !sectionIsOpen[button.tag]
        tableView.reloadSections([button.tag], with: .automatic)
    }
    
    
    
    
    func returnHeader(section: Int) -> UIView{
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = self.view.backgroundColor
        let image = UIImageView(frame: CGRect(x: 0, y: 20, width: 18, height: 18))
        image.image = headerImages[section]
        let label = UILabel(frame: CGRect(x: 30, y: 20, width: 150, height: 20))
        label.backgroundColor = .clear
        label.text = headerNames[section]
        label.font = UIFont(name: "Futura-Bold", size: 15)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let image1 = UIImageView(frame: CGRect(x: view.frame.width - 35, y: 25, width: 12, height: 8))
        
        image1.image = UIImage(named: sectionIsOpen[section] ? "chevron-up" : "chevron-down")
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        btn.backgroundColor = .clear
        btn.tag = section
        btn.addTarget(self, action: #selector(headerPressed), for: .touchUpInside)
        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(image1)
        view.addSubview(btn)
        return view
    }
    
}


//MARK: - Extension
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionIsOpen[section] ? cellNames[section].count : 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        returnHeader(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.5))
        view.backgroundColor = .white
        view.alpha = 0.1
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        25
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideTVC", for: indexPath) as! SideTVC
        cell.setText(text: cellNames[indexPath.section][indexPath.row])
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            self.dismiss(animated: true, completion: nil)
            menuCellDelegate?.cellPressed()
            
        }
    }
}
