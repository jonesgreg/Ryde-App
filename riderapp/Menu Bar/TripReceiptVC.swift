//
//  RideHistoryReceiptVC.swift
//  riderapp
//
//  Created by Gregory Jones on 10/4/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit



class TripReceiptViewController: UIViewController {
    
    let tripSummaryDetails = [
        TripSummary(pickup_Address: "2599 Cardinal Ave", pickup_City: "Philadelphia", pickup_Time: "7:42pm", dropoff_Address: "5600 City Ave", dropoff_City: "Philadelphia", dropoff_Time: "7:56pm")
    ]
    
    //MARK: -Properties
    var tableView: UITableView!
    
    override func viewDidLoad() {
        tripSummary()
        configureUI()
        configureNavigationController()
        constraintsLayout()
        tableViewConstraints()
       
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
           hideTabBarController()
        
      }
     
      override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          
          self.navigationController?.setNavigationBarHidden(false, animated: animated)
     }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationItem.title = "Ride History"
                   self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                   self.navigationController?.navigationBar.shadowImage = UIImage()
                             navigationController?.navigationBar.tintColor = .black
                             navigationController?.navigationBar.isTranslucent = false
                             navigationController?.navigationBar.backgroundColor = .white
                let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
              navigationController?.navigationBar.titleTextAttributes = textAttributes
               navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: .clear), for: .default)
               // Sets Bar's Shadow Image (Color) //
               navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: .lightGray)
               
               // Custom Back Button
               let backButton = UIButton(type: .system)
                           backButton.setBackgroundImage(#imageLiteral(resourceName: "menuBack"), for:.normal)
                           backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
                           backButton.width(constant: 20)
                           backButton.height(constant: 20)
                           self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func hideTabBarController() {
           tabBarController?.tabBar.isHidden = true
           edgesForExtendedLayout = UIRectEdge.bottom
           extendedLayoutIncludesOpaqueBars = true
       }
    

    
    //MARK: - Private functions
    
    private let driverPic: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "profile_icon"))
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            iv.width(constant: 90)
            iv.height(constant: 90)
        return iv
        
    }()
    
  private let thankYouNote: UILabel = {
          let label = UILabel()
              label.attributedText = NSMutableAttributedString(string: "Thank you for riding with Mike", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
          return label
      }()
    
    private let tripScreenShot: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "screenshot_map"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.width(constant: 420)
        iv.height(constant:420)
        return iv
    }()
    
  private lazy var tripStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [driverPic, thankYouNote])
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
            stackView.alignment = .center
            stackView.spacing = 0
        return stackView
    }()
    
    private func constraintsLayout() {
     
        view.addSubview(tripStackView)
       tripStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
       tripStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
       tripStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
      
     
       view.addSubview(tripScreenShot)
       tripScreenShot.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tripScreenShot.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
     
       
       
    }
    
    private func configureNavigationController() {
            navigationItem.title = "August 03, 2019, 4:50pm"
               self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
               self.navigationController?.navigationBar.shadowImage = UIImage()
                         navigationController?.navigationBar.tintColor = .black
                         navigationController?.navigationBar.isTranslucent = false
                         navigationController?.navigationBar.backgroundColor = .white
            let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
          navigationController?.navigationBar.titleTextAttributes = textAttributes
           
           
           // Custom Back Button
           let backButton = UIButton(type: .system)
                       backButton.setBackgroundImage(#imageLiteral(resourceName: "backarrow"), for:.normal)
                       backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
                       backButton.width(constant: 18)
                       backButton.height(constant: 18)
                       self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
         }
      
       private func configureUI() {
       view.backgroundColor = .white
           
         }
    
         func tripSummary() {
         tableView = UITableView()
         tableView.delegate = self
         tableView.dataSource = self
          tableView.register(UINib(nibName: "TripSummaryCell", bundle: nil), forCellReuseIdentifier: "TripSummaryCell")
        // let nib:UINib = UINib(nibName: TripSummaryCell.reuseIdentifier, bundle: nil)
       //  tableView.register(nib, forCellReuseIdentifier: TripSummaryCell.reuseIdentifier)
         tableView.tableFooterView = UIView()
         tableView.allowsSelection = true
         tableView.bounces = false
         tableView.separatorStyle = .singleLine
         tableView.showsVerticalScrollIndicator = false
         tableView.translatesAutoresizingMaskIntoConstraints = false
        }
    
    func tableViewConstraints() {
        view.addSubview(tableView)
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
      tableView.topAnchor.constraint(equalTo: tripScreenShot.bottomAnchor, constant: -45).isActive =
        true
      
    }
    
    // MARK: - Selectors

    @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
    }
       
}

extension TripReceiptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripSummaryDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: "TripSummaryCell", for: indexPath) as!  TripSummaryCell
        let tripSummary = tripSummaryDetails[indexPath.row]
        cell.setupTrip(trip: tripSummary)
        cell.hideSeparator()
        return cell
       
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           cell.backgroundColor = UIColor.white
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 214
    }
    
}
