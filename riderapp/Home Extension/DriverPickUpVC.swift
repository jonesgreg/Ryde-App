//
//  DriverPickUpVC.swift
//  riderapp
//
//  Created by Gregory Jones on 10/11/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit


private let reuseIdentifer = "DriverPickUpCell"

class DriverPickUpViewController: UIViewController {
    
   let driverDetails = [
    DriverPickUp(DriverProfilePic: "greg", DriverVehicle: "823XMR", DriverName: "Chris", DriverSchool: "Loyola University of Maryland")]
    
    //MARK: - Properties
 
  var tableView: UITableView!
  var backButton = DriverPickBottomButtons()
  var callButton = DriverPickBottomButtons()
 
  
    
    override func viewDidLoad() {
           super.viewDidLoad()
           setupView()
           constraintsLayout()
           tableViewSetup()
          tableViewConstraints()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarController()
    }
    override func viewWillDisappear(_ animated: Bool) {
        showTabBarController()
    }
    
    func hideTabBarController() {
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
        
    }

    func showTabBarController() {
        tabBarController?.tabBar.isHidden = false
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = false
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
    

 
    lazy var pickUpButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, callButton])
              stackView.translatesAutoresizingMaskIntoConstraints = false
              stackView.axis = .horizontal
              stackView.spacing = 80
              stackView.distribution = .fillEqually
              return stackView
    }()
    
    let driverStatus: UILabel = {
      let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.gilroySemiBold, size: 13)
        label.text = "DRIVER ARRIVES IN 5 MIN"
        label.translatesAutoresizingMaskIntoConstraints = false
            return label
         }()
    
    
    func setupView() {
        backButton = DriverPickBottomButtons(withImageName: "clear_button", labelText: "Cancel")
               callButton = DriverPickBottomButtons(withImageName: "call",labelText: "Contact")
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
            destinationView.height(constant: 270)
            
        destinationView.addSubview(topSeparator)
                   topSeparator.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor, constant: 28).isActive = true
                    topSeparator.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor, constant: -28).isActive = true
                    topSeparator.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 52).isActive = true
        
        destinationView.addSubview(bottomSeparator)
                   bottomSeparator.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor, constant: 28).isActive = true
                    bottomSeparator.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor, constant: -28).isActive = true
                   // bottomSeparator.topAnchor.constraint(equalTo: destinationView.bottomAnchor, constant: -120).isActive = true
        bottomSeparator.bottomAnchor.constraint(equalTo: destinationView.bottomAnchor, constant: -120).isActive = true
        view.addSubview(pickUpButtonsStackView)
        
        pickUpButtonsStackView.topAnchor.constraint(equalTo: bottomSeparator.bottomAnchor, constant: 20).isActive = true
      
        pickUpButtonsStackView.centerXAnchor.constraint(equalTo: destinationView.centerXAnchor).isActive = true
              
       view.addSubview(driverStatus)
    driverStatus.width(constant: 300)
       driverStatus.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 30).isActive = true
       driverStatus.centerXAnchor.constraint(equalTo: destinationView.centerXAnchor, constant: 80).isActive = true
        
        
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
               tableView.register(DriverPickUpCell.self, forCellReuseIdentifier: reuseIdentifer)
             tableView.tableFooterView = UIView()
            tableView.bounces = false
          tableView.separatorStyle = .singleLine
             tableView.showsVerticalScrollIndicator = false
             tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .clear
     }
        
       private func tableViewConstraints() {
        view.addSubview(tableView)
      tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor).isActive = true
             tableView.bottomAnchor.constraint(equalTo: bottomSeparator.bottomAnchor).isActive = true
             tableView.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor).isActive = true
          tableView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: -8).isActive = true
          
          }
        
    
     private func configureUI() {
         view.backgroundColor = .white
     }
    
  
}

extension DriverPickUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driverDetails.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! DriverPickUpCell
        let driverPickUp = driverDetails[indexPath.row]
           cell.hideSeparator()
          cell.driverPickUp = driverPickUp
           cell.selectionStyle = .none
           return cell
          
       }
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        
           }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 85
       }
}
