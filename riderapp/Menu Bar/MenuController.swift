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



 class MenuViewController: UIView, UITableViewDelegate, UITableViewDataSource, HeaderTableViewCellDelegate{
   
   
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseHeaderIdentifer) as! HeaderViewCell
        cell.headerDelegate = self
      
       cell.profileButton.addTarget(self, action: #selector(didSelectHeaderCell), for: .touchUpInside)
        return cell
        
        
    }
    
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        // Verison of the app
        let appVerison = UILabel(frame: CGRect(x: 10, y: 50, width: footerView.frame.width, height: 30))
        appVerison.attributedText = NSMutableAttributedString(string: "Fleet v1.0.0", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:Colors.lightGreyColor])
        footerView.addSubview(appVerison)
        
        return footerView
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
        
      
    }
    
    @objc func didSelectHeaderCell() {
        headerDelegate?.didSelectHeaderCell()
        print("NOOW")
     
    }
    
}


    
    






