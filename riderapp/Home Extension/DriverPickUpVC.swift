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
         setupView()
          constraintsLayout()
           tableViewSetup()
         //  tableViewConstraints()
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
    
  let topSeparator: UIView = {
      let view = UIView()
          view.height(constant: 1.0)
          view.layer.borderColor = Colors.lightGreyColor.cgColor
          view.layer.borderWidth = 3.0
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
    }()
   
    let bottomSeparator: UIView = {
         let view = UIView()
             view.height(constant: 1.0)
             view.layer.borderColor = Colors.lightGreyColor.cgColor
             view.layer.borderWidth = 3.0
             view.translatesAutoresizingMaskIntoConstraints = false
             return view
       }()
    
    func setupView() {
        self.view.addSubview(destinationView)
        self.view.addSubview(topSeparator)
        self.view.addSubview(bottomSeparator)
        self.view.addSubview(handler)
        
        
    }
    private func constraintsLayout() {
     view.addSubview(destinationView)
       destinationView.translatesAutoresizingMaskIntoConstraints = false
            destinationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 33).isActive = true
            destinationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
            destinationView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -12).isActive = true
            destinationView.height(constant: 250)
            
        destinationView.addSubview(topSeparator)
                   topSeparator.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor, constant: 28).isActive = true
                    topSeparator.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor, constant: -28).isActive = true
                    topSeparator.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 52).isActive = true
        
        destinationView.addSubview(bottomSeparator)
                   bottomSeparator.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor, constant: 28).isActive = true
                    bottomSeparator.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor, constant: -28).isActive = true
                   // bottomSeparator.topAnchor.constraint(equalTo: destinationView.bottomAnchor, constant: -120).isActive = true
        bottomSeparator.bottomAnchor.constraint(equalTo: destinationView.bottomAnchor, constant: -100).isActive = true
              

              
        
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
            
             tableView.bounces = false

        // Set resizable table bounds
       tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

             tableView.separatorStyle = .singleLine
             tableView.showsVerticalScrollIndicator = false
             tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .clear
     }
        
       private func tableViewConstraints() {
        view.addSubview(tableView)
        tableView.bottomAnchor.constraint(equalTo: destinationView.bottomAnchor).isActive = true
       // tableView.widthAnchor.constraint(equalToConstant: 353).isActive = true
        tableView.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 60).isActive = true
          
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
           return 100
       }
}
