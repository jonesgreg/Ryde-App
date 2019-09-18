//
//  MenuController.swift
//  riderapp
//
//  Created by Gregory Jones on 9/13/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
private let reuseIdentifer = "MenuOptionCell"


class MenuController: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var menuTitle = [String]()
    var tableView: UITableView!
    var delegate: menuBarViewDelegate?
 
    
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
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.bounces = false
        
       // tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
       // tableView.backgroundColor = .clear
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
      
    let menuOption = MenuOption(rawValue: indexPath.row)
            cell.descriptionLabel.text = menuOption?.description
            cell.iconImageView.image = menuOption?.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        
        // Edit Profile Icon
        let profileButton = UIButton(frame: CGRect(x: tableView.frame.width-170, y: 10, width: 90, height: 90))
          profileButton.layer.masksToBounds = false
          profileButton.setImage(#imageLiteral(resourceName: "profile_icon"), for: .normal)
          headerView.addSubview(profileButton)
        
        // User Name
        
      
        // Horizontal Separator for Header
        let separator = UILabel()
        separator.frame = CGRect(x:1, y:140, width:300, height: 0.4)
        separator.backgroundColor = UIColor.lightGray
        headerView.addSubview(separator)
        return headerView
    }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    

  
    }

