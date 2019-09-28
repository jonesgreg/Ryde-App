//
//  EditProfileVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/20/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

private let reuseIdentifer = "ProfileOptionCell"

class EditProfileViewController: UIViewController {
    
     //MARK: - Properties
    var tableView: UITableView!
    var delegate: ProfileDelegate?
    
    
    //MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        tableViewConstraints()
        configureNavigationBar()
        profileHeader()
        
       
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    private func configureNavigationBar() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.montserratSemiBold, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.bounces = false
        
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func tableViewConstraints() {
       view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
       tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
       tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
       tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
       }
     
    func profileHeader() {
        
        let profileButton = UIButton()
        profileButton.layer.masksToBounds = false
        profileButton.setImage(#imageLiteral(resourceName: "profile_icon"), for: .normal)
        profileButton.width(constant: 80)
        profileButton.height(constant: 80)
      //  profileButton.addTarget(self, action: #selector(handleTapped), for: <#T##UIControl.Event#>)
        view.addSubview(profileButton)
        
        
        let userLabel = UITextView()
        let attributedText = NSMutableAttributedString(string: "Greg Jones", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\nSaint Joseph's University", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]))
       
        userLabel.attributedText = attributedText
        view.addSubview(userLabel)
        
       let profileStackView = UIStackView(arrangedSubviews: [profileButton, userLabel])
           profileStackView.axis = .horizontal
           profileStackView.translatesAutoresizingMaskIntoConstraints = false
           profileStackView.distribution = .fill
           profileStackView.alignment = .fill
           profileStackView.spacing = 8.0
           view.addSubview(profileStackView)
          
           profileStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           profileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
          
    }
    
    func didSelectProfileOption(profileOption: ProfileOption) {
        
        switch profileOption {
             
        case .Email:
            let emailController = EditEmailViewController()
            self.navigationController?.pushViewController(emailController, animated: false)
        case .Phone:
           let phoneController = EditNumberViewController()
                      self.navigationController?.pushViewController(phoneController, animated: false)
            
        case .Home:
            let homeController = EditHomeViewController()
            self.navigationController?.pushViewController(homeController, animated: false)
        case .School:
            let schoolController = EditSchoolViewController()
            self.navigationController?.pushViewController(schoolController, animated: false)
        }
        
    }
    
   
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! ProfileOptionCell
             
           let profileOption = ProfileOption(rawValue: indexPath.row)
                   cell.descriptionLabel.text = profileOption?.description
                   cell.iconImageView.image = profileOption?.image
               return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
               
               let accountInfoLabel = UILabel.init(frame: CGRect(x: 4, y: 4, width: headerView.frame.size.width-150, height: headerView.frame.size.height-10))
               let attributedText = NSMutableAttributedString(string: "Account Info", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
                accountInfoLabel.attributedText = attributedText
               
              headerView.addSubview(accountInfoLabel)
          
             return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileOption = ProfileOption(rawValue: indexPath.row)
        didSelectProfileOption(profileOption: profileOption!)
    }
    

    
    
}
    
    

