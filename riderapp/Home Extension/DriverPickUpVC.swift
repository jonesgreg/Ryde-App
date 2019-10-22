//
//  DriverPickUpVC.swift
//  riderapp
//
//  Created by Gregory Jones on 10/11/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit


class DriverPickUpViewController: UIViewController {
    
    let driverPickDetails = [
        DriverPickUp(PickUpStatus: "ARRIVES IN 5 MIN", DriverProfilePic: #imageLiteral(resourceName: "profile_icon"), DriverVehicle: "Vehicle #1 5DM91439", DriverName: "Mike", DriverSchool: "Saint Joseph's University")]
    
    //MARK: - Properties
 
  var tableView: UITableView!
  
    
    override func viewDidLoad() {
           super.viewDidLoad()
           configureUI()
          constraintsLayout()
           tableViewSetup()
            tableViewConstraints()
       }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           // Hide the navigation bar on the this view controller
           self.navigationController?.setNavigationBarHidden(true, animated: animated)
           
       }
    
    //MARK: Private functions
      
     let destinationView: UIView = {
                  let view =  UIView()
                      view.layer.shadowColor = UIColor.black.cgColor;
                      view.layer.shadowOpacity = 0.5;
                      view.layer.shadowRadius  = 2.0;
                      view.layer.shadowOffset  = CGSize(width :0, height :1)
                      view.layer.masksToBounds = false;
                      view.layer.cornerRadius  =  17;
                      view.backgroundColor     =  .white
                      view.translatesAutoresizingMaskIntoConstraints = false
                      return view
          }()
    
    let handler: UIView =  {
            let view = UIView()
                view.backgroundColor = Colors.lightGreyColor
                view.layer.masksToBounds = false
                view.layer.cornerRadius = 2
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
               }()
    
    
    private func constraintsLayout() {
     view.addSubview(destinationView)
      destinationView.translatesAutoresizingMaskIntoConstraints = false
           destinationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 33).isActive = true
           destinationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
           destinationView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -8).isActive = true
           destinationView.height(constant: 240)
        
        
        view.addSubview(handler)
        handler.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 10).isActive = true
        handler.centerXAnchor.constraint(equalTo: destinationView.centerXAnchor).isActive = true
        handler.width(constant: 63)
        handler.height(constant: 4)
        }
    
    private func tableViewSetup() {
             tableView = UITableView()
             tableView.delegate = self
             tableView.dataSource = self
              tableView.register(UINib(nibName: "DriverPickUpCell", bundle: nil), forCellReuseIdentifier: "DriverPickUpCell")
             tableView.tableFooterView = UIView()
             tableView.allowsSelection = true
             tableView.bounces = false
             tableView.separatorStyle = .singleLine
             tableView.showsVerticalScrollIndicator = false
             tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .clear
     }
        
       private func tableViewConstraints() {
        view.addSubview(tableView)
        tableView.bottomAnchor.constraint(equalTo: destinationView.bottomAnchor, constant: -5).isActive = true
        tableView.width(constant: 379)
        tableView.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 10).isActive = true
          
          }
        
    
     private func configureUI() {
         view.backgroundColor = .white
     }
}

extension DriverPickUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driverPickDetails.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
       let cell = tableView.dequeueReusableCell(withIdentifier: "DriverPickUpCell", for: indexPath) as!  DriverPickUpCell
        let driverPickUp = driverPickDetails[indexPath.row]
           cell.hideSeparator()
           cell.driverPickUp(pickUp: driverPickUp)
           cell.selectionStyle = .none
           return cell
          
       }
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        
           }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 196
       }
}
