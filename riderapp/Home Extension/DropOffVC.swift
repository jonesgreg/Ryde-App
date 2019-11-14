//
//  DropOffLocationVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/5/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class DropOffLocationViewController: UIViewController {
    
    var handlerArea = HandlerAreaDesign()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        constraintsLayout()
        hideTabBarController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        dropOffInput.becomeFirstResponder()
        CurrentLocationInput.delegate = self
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
    
    private let dropOffView: UIView = {
        let view = UIView()
            view.layer.shadowColor = UIColor.black.cgColor;
            view.layer.masksToBounds = false;
            view.layer.cornerRadius  =  10;
            view.layer.borderWidth   = 2.0;
                              view.layer.borderColor = UIColor.darkGray.cgColor
            view.backgroundColor     =  .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
   private let separator: UIView = {
           let view = UIView()
          // view.backgroundColor = Colors.lightGreyColor
           view.height(constant: 1.0)
           view.layer.borderColor = UIColor.darkGray.cgColor
           view.layer.borderWidth = 3.0
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    private let PickUpLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Pickup", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 15) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
           label.attributedText = attributedText
            label.translatesAutoresizingMaskIntoConstraints = true
           label.textAlignment = .left
         
          return label
    }()
    
    private let DropOffLabel: UILabel = {
           let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Drop-off", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 15) as Any, NSAttributedString.Key.foregroundColor:Colors.fleetGreen])
              label.attributedText = attributedText
               label.translatesAutoresizingMaskIntoConstraints = true
              label.textAlignment = .left
             return label
       }()
    
private let pickUpPoint: UIImageView = {
           let iv = UIImageView(image: #imageLiteral(resourceName: "pickup_circle"))
           iv.contentMode = .scaleAspectFit
           iv.width(constant: 15)
           iv.height(constant: 15)
           iv.translatesAutoresizingMaskIntoConstraints = false
           return iv
           
       }()
    
    private let dropOffPoint: UIImageView = {
              let iv = UIImageView(image: #imageLiteral(resourceName: "dropoff_circle"))
              iv.contentMode = .scaleAspectFit
              iv.width(constant: 15)
              iv.height(constant: 15)
              iv.translatesAutoresizingMaskIntoConstraints = false
              return iv
              
          }()
    
    private let CurrentLocationInput: UITextField = {
                   let textField = currentLocationSearch()
        textField.attributedPlaceholder = NSAttributedString(string: "Current Location", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.black])
                       textField.textColor = UIColor.black
                       textField.textAlignment = .left
                   
                       return textField
               }()
    private let dropOffInput: UITextField = {
        let textField = searchLocation()
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            textField.textColor = UIColor.black
            textField.textAlignment = .left
            return textField
    }()
    
    private func constraintsLayout() {
        view.addSubview(dropOffView)
        dropOffView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 130))
        
        view.addSubview(separator)
              separator.leadingAnchor.constraint(equalTo: dropOffView.leadingAnchor, constant: 2).isActive = true
              separator.trailingAnchor.constraint(equalTo: dropOffView.trailingAnchor, constant: -2).isActive = true
              separator.topAnchor.constraint(equalTo: dropOffView.topAnchor, constant: 65).isActive = true
              
        
        view.addSubview(PickUpLabel)
        PickUpLabel.anchor(top: dropOffView.topAnchor, bottom: separator.topAnchor, leading: dropOffView.leadingAnchor, trailing: dropOffView.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 30, right: 0))
        
        view.addSubview(DropOffLabel)
        DropOffLabel.anchor(top: separator.bottomAnchor, bottom: dropOffView.bottomAnchor, leading: dropOffView.leadingAnchor, trailing: dropOffView.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 28, right: 0))
        
      
        view.addSubview(pickUpPoint)
        pickUpPoint.anchor(top: dropOffView.topAnchor, bottom: nil, leading: dropOffView.leadingAnchor, trailing: nil, padding: .init(top: 28, left: 13, bottom: 0, right: 0))
        
        view.addSubview(dropOffPoint)
        dropOffPoint.anchor(top: dropOffView.topAnchor, bottom: nil, leading: dropOffView.leadingAnchor, trailing: nil, padding: .init(top: 88, left: 13, bottom: 0, right: 0))
        
        view.addSubview(CurrentLocationInput)
        CurrentLocationInput.anchor(top: dropOffView.topAnchor, bottom: separator.topAnchor, leading: dropOffView.leadingAnchor, trailing: dropOffView.trailingAnchor, padding: .init(top: 20, left: 40, bottom: 0, right: 0))
        
        view.addSubview(dropOffInput)
        dropOffInput.anchor(top: separator.bottomAnchor, bottom: dropOffView.bottomAnchor, leading: dropOffView.leadingAnchor, trailing: dropOffView.trailingAnchor, padding: .init(top: 20, left: 40, bottom: 0, right: 0))
    }
    
    

    private func configureNavigationBar() {
        navigationItem.title = "Drop-off"
        navigationController?.navigationBar.isTranslucent = false
       let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
       navigationController?.navigationBar.titleTextAttributes = textAttributes
      
        // Custom back button
        let backButton = UIButton(type: .system)
            backButton.setTitle("Cancel", for: .normal)
            backButton.setTitleColor(.black, for: .normal)
            backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // Custom Done Button
        let doneButton = UIButton(type: .system)
            doneButton.setTitle("Done", for: .normal)
                  doneButton.setTitleColor(.black, for: .normal)
                  doneButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
                  self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
   
    private func configureUI() {
        view.backgroundColor = .white
    }
    
   
    // MARK: - Selectors
          @objc private func handlePreviousPage() {
           let homeViewController = HomeViewController()
              self.navigationController?.pushViewController(homeViewController, animated: false)
              
          }
}

extension DropOffLocationViewController: UITextFieldDelegate {
    // Stop Editing on Return Key Tap
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            
        }
      private func textFieldShouldReturn(textField: UITextField!) -> Bool {
        //  textField.resignFirstResponder()
          return true
      }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == CurrentLocationInput) {
              let pickUpViewController = PickUpViewController()
                                self.navigationController?.pushViewController(pickUpViewController, animated: false)
           return false
          }
        return true
      }
    
}

