//
//  RideHistoryVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
private let reuseIdentifer = "RideHistoryCell"

class RideHistoryViewController: UIViewController {
    
    let tripDetails = [
        RideHistory(profileImage: "profile_icon", date: "Aug 03, 6:20pm", tripDistance: "2.2mi, 5min") ]
      
    
    
    //MARK: - Properties
    var tableView: UITableView!
    
  
    override func viewDidLoad() {
        configureUI()
        configureTableView()
        tableViewConstraints()
        configureNavigationController()
        
        
            
        
        
    }
       override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         // Hide the navigation bar on the this view controller
        self.tableView.deselectSelectedRow(animated: false)
        

         
           
       
     }
    
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
          self.tableView.deselectSelectedRow(animated: true)
          self.navigationController?.setNavigationBarHidden(false, animated: animated)
     }
     
 func configureTableView() {
       tableView = UITableView()
       tableView.delegate = self
       tableView.dataSource = self
       tableView.register(RideHistoryCell.self, forCellReuseIdentifier: reuseIdentifer)
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
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      
   }
   
    
    private func configureNavigationController() {
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
   
    private func configureUI() {
    view.backgroundColor = .white
        
      }
    

 // MARK: - Selectors

@objc private func handlePreviousPage() {
    self.navigationController?.popViewController(animated: false)
    }
    
  
}

extension RideHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! RideHistoryCell
       let tripInfo = tripDetails[indexPath.item]
            cell.trip = tripInfo
            return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tripReceipt = TripReceiptViewController()
        self.navigationController?.pushViewController(tripReceipt, animated: false)
          
       }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
   
}

