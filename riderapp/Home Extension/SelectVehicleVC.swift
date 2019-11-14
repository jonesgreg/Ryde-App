//
//  DestinationMapVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/5/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import Lottie
import GoogleMaps

class SelectVehicleViewController: UIViewController {
    
    
    //MARK: - Properties
    var tableView: UITableView!
    let cardHeight: CGFloat = 300
    weak var animateDriverPickView: AnimateDriverPickUpDelegate?
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           setupView()
           constraintsLayout()
           tableViewSetup()
          tableViewConstraints()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          tableView.deselectSelectedRow(animated: false)
          hideTabBarController()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
                  // view.layer.cornerRadius  =  17;
                   view.backgroundColor     =  .white
                   view.translatesAutoresizingMaskIntoConstraints = false
                   return view
       }()
    
     let rideNowButton: UIButton = {
        let button = greenButton(type: .system)
        button.setTitle("Select Fleet", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.gilroyBold, size: 22)
        button.addTarget(self, action: #selector(handleAnimation), for: .touchUpInside)
        return button
    }()
    
   
    
     let separator: UIView = {
            let view = UIView()
           
        view.height(constant: 1.0)
        view.layer.borderColor = Colors.lightGreyColor.cgColor
        view.layer.borderWidth = 3.0
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
   let CurrentLocationInput: UITextField = {
                     let textField = currentLocationSearch()
                     textField.attributedPlaceholder = NSAttributedString(string: "Current Location", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.black])
                         textField.textColor = UIColor.black
                         textField.textAlignment = .left
                     
                         return textField
                 }()
    
    
     let PickUpInput: UITextField = {
                       let textField = searchLocation()
                       textField.attributedPlaceholder = NSAttributedString(string: "Pick Up Location", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.black])
                           textField.textColor = UIColor.black
                           textField.textAlignment = .right
                       
                           return textField
                   }()
    
    let directionArrow: UIImageView = {
          let iv = UIImageView(image: #imageLiteral(resourceName: "directionarrow"))
          iv.contentMode = .scaleAspectFit
          iv.translatesAutoresizingMaskIntoConstraints = false
          iv.clipsToBounds = true
          iv.width(constant: 25)
          iv.height(constant:25)
          return iv
      }()
    
   func setupView() {
        self.view.addSubview(destinationView)
        self.view.addSubview(separator)
        self.view.addSubview(rideNowButton)
        self.view.addSubview(CurrentLocationInput)
        self.view.addSubview(PickUpInput)
        self.view.addSubview(directionArrow)
       
    }
  
    
    private func constraintsLayout() {
          view.addSubview(destinationView)
             destinationView.translatesAutoresizingMaskIntoConstraints = false
             destinationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 33).isActive = true
             destinationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
             destinationView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
             destinationView.height(constant: 300)
       
     
    
       destinationView.addSubview(separator)
              separator.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor, constant: 28).isActive = true
              separator.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor, constant: -28).isActive = true
              separator.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 52).isActive = true
        
        destinationView.addSubview(rideNowButton)
       rideNowButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top:0, left: 32, bottom: 30, right: 32), size: .init(width: 0, height: 55))
   
       destinationView.addSubview(CurrentLocationInput)
       CurrentLocationInput.anchor(top: destinationView.topAnchor, bottom: nil, leading: destinationView.leadingAnchor, trailing: destinationView.trailingAnchor, padding: .init(top: 25, left: 40, bottom: 0, right: 0))
        
       destinationView.addSubview(PickUpInput)
         PickUpInput.anchor(top: destinationView.topAnchor, bottom: nil, leading: destinationView.leadingAnchor, trailing: destinationView.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 40))
        
       destinationView.addSubview(directionArrow)
        directionArrow.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 20).isActive = true
        directionArrow.centerXAnchor.constraint(equalTo: destinationView.centerXAnchor).isActive = true
  
    }
 func tableViewSetup() {
          tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
             tableView.register(UINib(nibName: "VehicleCell", bundle: nil), forCellReuseIdentifier: "VehicleCell")
            tableView.tableFooterView = UIView()
            tableView.allowsSelection = true
            tableView.bounces = false
            tableView.separatorStyle = .singleLine
            tableView.showsVerticalScrollIndicator = false
            tableView.translatesAutoresizingMaskIntoConstraints = false
    }
       
     func tableViewConstraints() {
        view.addSubview(tableView)
       tableView.bottomAnchor.constraint(equalTo: rideNowButton.topAnchor).isActive = true
        tableView.width(constant: 384)
   
         tableView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 18).isActive =
           true 
     
         }
       

    
    // MARK: - Selectors
   @objc func handleAnimation() {
    animateDriverPickView?.handleAnimationDriverPick()
    }
   
    
}


extension SelectVehicleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
       let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath) as!  VehicleCell
           cell.hideSeparator()
         //  cell.selectionStyle = .none
           return cell
          
       }
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
              cell.backgroundColor = UIColor.white
        
           }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 91
            
       }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
