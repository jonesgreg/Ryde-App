//
//  SettingsVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

private let reuseIdentifer = "SettingOptionCell"

class SettingsViewController: UIViewController {
    
    
    //MARK: - Properties
    
    var delegate: SettingsDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingListTableView)
        configureNavigationBar()
       
        
    }

       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private lazy var settingListTableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        
       tableView.register(SettingOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
       // tableView.estimatedRowHeight = 60
         tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView() // Remove extra cells
        tableView.reloadData()
       // tableView.allowsSelection = true
        tableView.backgroundColor = Colors.lighterGrey
        
        return tableView
    }()
    
    private func configureNavigationBar() {
         navigationItem.title = "Settings"
             navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.montserratSemiBold, size: 15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
      navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(handlePreviousPage), imageName: "menuBack")
       
    }
    // MARK: - Selectors
    @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
    }
    
 
    
    func didSelectSettingOption(settingOption: SettingOptions) {
        
        switch settingOption {
            
        case .Profile:
             let profileController = EditProfileViewController()
                      self.navigationController?.pushViewController(profileController, animated: false)
        case .Email:
           let emailController = EditEmailViewController()
              self.navigationController?.pushViewController(emailController, animated: false)
        case .phoneNumber:
                  let phoneController = EditNumberViewController()
                  self.navigationController?.pushViewController(phoneController, animated: false)
        case .Home:
                  let homeController = EditHomeViewController()
                  self.navigationController?.pushViewController(homeController, animated: false)
        case .DriveAndEarn:
                  let driveEarnController = DriveAndEarnViewController()
                  self.navigationController?.pushViewController(driveEarnController, animated: false)
        case .Privacy:
                  let privacyController = PrivacyViewController()
                  self.navigationController?.pushViewController(privacyController, animated: false)
        case .TermsOfUse:
                  let termsController = TermsViewController()
                  self.navigationController?.pushViewController(termsController, animated: false)
       
            
        }
    }
   
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! SettingOptionCell
    
    let settingOption = SettingOptions(rawValue: indexPath.row)
        cell.descriptionLabel.text = settingOption?.description
        cell.iconImageView.image = settingOption?.image
        
        return cell
    
    }
  
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Colors.lighterGrey
        return view
    }
   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Colors.lighterGrey
        
     
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 50, width: tableView.frame.size.width, height: 60)
        button.setTitle("Log out", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 15)
        button.setTitleColor(Colors.fleetGreen, for: .normal)
      
        let appVerison = UILabel(frame: CGRect(x: 0, y: 120, width: tableView.frame.size.width, height: 80))
        appVerison.attributedText = NSMutableAttributedString(string: "Fleet - Verison 1.0.0", attributes:
            [NSAttributedString.Key.font:UIFont(name: Fonts.montserratRegular, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        appVerison.textAlignment = .center
       view.addSubview(appVerison)
      view.addSubview(button)
        
        
      return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
 /*   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    } */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let settingOption = SettingOptions(rawValue: indexPath.row)
       // delegate?.handleSettingsToggle(forSettingOption: settingOption)
        didSelectSettingOption(settingOption: settingOption!)
        
       
    }
    
    
    
}

extension SettingsViewController: SettingsDelegate {
    
    func handleSettingsToggle(forSettingOption: SettingOptions?) {
          switch forSettingOption {
        case .Profile?:
            let profileController = EditProfileViewController()
            self.navigationController?.pushViewController(profileController, animated: true)
        case .Email?:
            let emailController = EditEmailViewController()
            self.navigationController?.pushViewController(emailController, animated: true)
        case .phoneNumber?:
            let phoneController = EditNumberViewController()
            self.navigationController?.pushViewController(phoneController, animated: true)
        case .Home?:
            let homeController = EditHomeViewController()
            self.navigationController?.pushViewController(homeController, animated: true)
        case .DriveAndEarn?:
            let driveEarnController = DriveAndEarnViewController()
            self.navigationController?.pushViewController(driveEarnController, animated: true)
        case .Privacy?:
            let privacyController = PrivacyViewController()
            self.navigationController?.pushViewController(privacyController, animated: true)
        case .TermsOfUse?:
            let termsController = TermsViewController()
            self.navigationController?.pushViewController(termsController, animated: true)
            
        case .none:
            break
        }
    }
}

  
