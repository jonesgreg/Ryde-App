//
//  MenuController.swift
//  riderapp
//
//  Created by Gregory Jones on 9/13/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit


private let reuseIdentifer = "MenuOptionCell"
private let reuseHeaderIdentifer = "HeaderViewCell"

class MenuViewController: UIView, UITableViewDelegate, UITableViewDataSource{
   
    let headerDetails = [
        Header(userProfileIcon: "profile_icon", userName: "Greg", viewProfile: "View Profile")
    ]
    
    //MARK: -Properties
   
    var tableView: UITableView!
    var delegate: menuBarViewDelegate?
    var headerDelegate: HeaderTableViewCellDelegate?
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureTableView()
        tableViewConstraints()
        
        }
    

   
              
required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
     tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.register(HeaderViewCell.self, forCellReuseIdentifier: reuseHeaderIdentifer)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
       
    }
   
    
   func tableViewConstraints() {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
 
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
      
    let menuOption = MenuOption(rawValue: indexPath.row)
            cell.descriptionLabel.text = menuOption?.description
            cell.iconImageView.image = menuOption?.image
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerDetails.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: reuseHeaderIdentifer) as! HeaderViewCell
        headerView.headerDelegate = self
      
        let header = headerDetails[section]
        headerView.profileHeader = header
      
     
        return headerView
        
    }
    
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 40))
        // Verison of the app
        let appVerison = UILabel(frame: CGRect(x: 10, y: 0, width: footerView.frame.width, height: 30))
        appVerison.attributedText = NSMutableAttributedString(string: "Fleet v1.0.0", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:Colors.lightGreyColor])
        footerView.addSubview(appVerison)
       
        let signUpButton = UIButton(type: .custom)
            signUpButton.setTitle("SIGN UP TO DRIVE", for: .normal)
            signUpButton.titleLabel?.font = UIFont(name: Fonts.gilroySemiBold, size: 16)
            signUpButton.setTitleColor(UIColor.white, for: .normal)
            signUpButton.backgroundColor = Colors.fleetGreen
            signUpButton.layer.borderColor = Colors.fleetGreen.cgColor
            signUpButton.layer.masksToBounds = false
            signUpButton.layer.shadowColor = Colors.darkGreyColor.cgColor
            signUpButton.layer.shadowOpacity = 0.5
            signUpButton.layer.shadowRadius = 2
            signUpButton.layer.shadowOffset = CGSize(width: 0, height: 1)
            signUpButton.layer.cornerRadius = 25
            signUpButton.frame = CGRect(x: 20, y: 100, width: 200, height: 50)
            footerView.addSubview(signUpButton)
            return footerView
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
            indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: false)
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
  /*  func selectedHeader(sender: AnyObject) {
        headerDelegate?.didSelectHeaderViewCell(Selected: true, UserHeader: self)
        print("PLEASE WORK NOW!'")
        
    } */
}

extension MenuViewController: HeaderTableViewCellDelegate {
    @objc func didSelectHeaderViewCell(Selected: Bool, UserHeader: HeaderViewCell) {
        print("Cell is selected")
    }
    
    
}


    
    






