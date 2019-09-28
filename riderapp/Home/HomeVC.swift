//
//  HomePageViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 7/24/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController{

    
    //MARK: - Properties
    
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
    var menuBarView: MenuViewController!
    var blackScreen: UIView!
    
 
    

  
// MARK: - Overriden function
    
    override func viewDidLoad() {
        super.viewDidLoad()
    MenuBarSetup()
    BlackScreenSetup()
    setupGoogleMaps()
    configureUI()
   constraintsLayout()
}
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
      self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Private functions
   private let destinationView: UIView = {
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
    
  private let menuButton: UIButton = {
        let button = whiteCircleButton(type: .custom)
        button.addTarget(self, action: #selector(handleMenuAction), for: .touchUpInside)
            return button
    }()
    
    private let menuButtonImage: UIImageView = {
            let imageView = UIImageView(image:#imageLiteral(resourceName: "menu"))
                imageView.contentMode = .scaleAspectFit
                imageView.width(constant: 22)
                imageView.height(constant: 22)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
    }()
    
   private let navigationIcon: UIButton = {
        let button = whiteCircleButton(type: .system)
           //  button.addTarget(self, action: //#selector(handleNextPage), for: .touchUpInside)
            return button
    }()
    
    private let navigationIconImage: UIImageView = {
            let imageView = UIImageView(image:#imageLiteral(resourceName: "navigation"))
                imageView.contentMode = .scaleAspectFit
                imageView.width(constant: 22)
                imageView.height(constant: 22)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
    }()
   
    private let greetingTitle: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Good evening", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
       attributedText.append(NSAttributedString(string: "\nWhere are you going?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
            textView.attributedText = attributedText
            textView.translatesAutoresizingMaskIntoConstraints = true
            textView.textAlignment = .left
           textView.isEditable = false
           textView.isScrollEnabled = false
        return textView
    }()
 private let whereToView: UIView = {
            let view = UIView()
                view.layer.shadowColor = UIColor.black.cgColor;
                    view.layer.shadowOpacity = 0.3;
                    view.layer.shadowRadius  = 2;
                    view.layer.shadowOffset  = CGSize(width :0, height :1)
                    view.layer.masksToBounds = false;
                    view.layer.cornerRadius  =  12;
                    view.layer.borderWidth   = 0.0;
                    view.backgroundColor     =  .white
                    view.translatesAutoresizingMaskIntoConstraints = false
        
               // view.layer.cornerRadius =
                return view
    }()
    
    private let whereToButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Search your destination", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratMedium, size: 15)
        button.setTitleColor(Colors.darkGreyColor, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleDropOff), for: .touchUpInside)
        return button
    }()
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "seachicon"))
        imageView.contentMode = .scaleAspectFit
        imageView.width(constant: 20)
        imageView.height(constant: 20)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   
    private let previousLocationButton: UIButton = {
            let button = greenCircleButton(type: .system)
            let img = UIImage(named: "home")
            button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 24.5, left: 24.5, bottom: 24.5, right: 24.5)
           return button
    }()
    
    private let previousTextButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedText = NSMutableAttributedString(string: "Residence Hall", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\n2599 Cardinal Ave #2401, Philadelphia, PA 19131", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleDestinationMap), for: .touchUpInside)
        
        return button
        
    }()
    
private let campusButton: UIButton = {
        let button = greenCircleButton(type: .system)
        let img = UIImage(named: "campus")
            button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 26.5, left: 26.5, bottom: 26.5, right: 26.5)
            return button
    }()
    
    private let campusTextButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedText = NSMutableAttributedString(string: "Campus", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
         attributedText.append(NSAttributedString(string: "\n5600 City Ave, Philadelphia, PA 19131", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleDestinationMap), for: .touchUpInside)
        return button
        
    }()
   
   private lazy var previousSelectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousLocationButton, previousTextButton])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        return stackView
    }()
    
    private lazy var campusSelectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [campusButton, campusTextButton])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        return stackView
    }()
    

    
private func setupGoogleMaps() {
    let camera = GMSCameraPosition.camera(withLatitude: 39.277444, longitude: -76.689768, zoom: 12)
      mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 500), camera: camera)
     mapView?.center = self.view.center
     
    self.view.addSubview(mapView!)
    mapView?.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
    mapView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
    mapView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
    mapView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -280).isActive=true
    mapView?.addSubview(menuButton)
    mapView?.addSubview(menuButtonImage)
    mapView?.addSubview(navigationIcon)
    mapView?.addSubview(navigationIconImage)
    mapView?.translatesAutoresizingMaskIntoConstraints = false
    self.mapView?.isMyLocationEnabled = true
      self.locationManager.delegate = self // Fetch current location
      self.locationManager.startUpdatingLocation() //
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "fleetgreen", withExtension: "json") {
                mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
private func constraintsLayout() {

       view.addSubview(destinationView)
      destinationView.topAnchor.constraint(equalTo: mapView!.bottomAnchor, constant: -5).isActive = true
      destinationView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
      destinationView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.65).isActive = true
      destinationView.translatesAutoresizingMaskIntoConstraints = false
    
     view.addSubview(greetingTitle)
    greetingTitle.anchor(top: destinationView.topAnchor, bottom: destinationView.bottomAnchor, leading: destinationView.leadingAnchor, trailing: destinationView.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 0))
    
    view.addSubview(whereToView)
     whereToView.anchor(top: destinationView.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 76, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
   
    view.addSubview(whereToButton)
    whereToButton.anchor(top: whereToView.topAnchor, bottom: nil, leading: whereToView.leadingAnchor, trailing: whereToView.trailingAnchor, padding: .init(top: 10, left: 50, bottom: 0, right: 0))
    
    view.addSubview(searchIcon)
    searchIcon.anchor(top: whereToView.topAnchor, bottom: nil, leading: whereToView.leadingAnchor, trailing: nil, padding: .init(top: 15, left: 16, bottom: 0, right: 0))
    
    view.addSubview(previousSelectionStackView)
   previousSelectionStackView.topAnchor.constraint(equalTo: whereToView.bottomAnchor, constant: 16).isActive = true
   previousSelectionStackView.leadingAnchor.constraint(equalTo: whereToView.leadingAnchor, constant: 16).isActive = true
   previousSelectionStackView.trailingAnchor.constraint(equalTo: whereToView.trailingAnchor).isActive = true
    
    view.addSubview(campusSelectionStackView)
    campusSelectionStackView.topAnchor.constraint(equalTo: previousSelectionStackView.bottomAnchor, constant: 14).isActive = true
    campusSelectionStackView.leadingAnchor.constraint(equalTo: previousSelectionStackView.leadingAnchor).isActive = true
   campusSelectionStackView.trailingAnchor.constraint(equalTo: previousSelectionStackView.trailingAnchor).isActive = true
 
    
    // MAP Buttons
     
     menuButton.topAnchor.constraint(equalTo: mapView!.topAnchor, constant: 40).isActive = true
     menuButton.leadingAnchor.constraint(equalTo: mapView!.leadingAnchor, constant: 12).isActive = true
     menuButtonImage.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor).isActive = true
     menuButtonImage.centerXAnchor.constraint(equalTo: menuButton.centerXAnchor).isActive = true
    
    navigationIcon.bottomAnchor.constraint(equalTo: mapView!.bottomAnchor, constant: -20).isActive = true
    navigationIcon.trailingAnchor.constraint(equalTo: mapView!.trailingAnchor, constant: -20).isActive = true
    navigationIconImage.centerYAnchor.constraint(equalTo: navigationIcon.centerYAnchor).isActive = true
    navigationIconImage.centerXAnchor.constraint(equalTo: navigationIcon.centerXAnchor).isActive = true
   
 
   
  
   }
    private func configureUI() {
    view.backgroundColor = .white
        
      }
    
    // MARK: - Handlers
    
    @objc func handleMenuAction() {
        animateSlideMenu()
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
        generator.impactOccurred()
        
    }
    
    func animateSlideMenu() {
        blackScreen.isHidden = false
        UIView.animate(withDuration: 0.6, animations:  {
            self.menuBarView.frame = CGRect(x:0, y:0, width: 220, height: self.menuBarView.frame.height)
            
        }) {(complete) in
            self.blackScreen.frame = CGRect(x: self.menuBarView.frame.width, y: 0, width:self.view.frame.width - self.menuBarView.frame.width, height: self.view.bounds.height + 100)
        }
    }
    func MenuBarSetup() {
        menuBarView = MenuViewController(frame: CGRect(x:0, y:0, width: 0, height: self.view.frame.height))
        menuBarView.delegate = self
        menuBarView.layer.zPosition = 100
        self.view.isUserInteractionEnabled = true
        self.navigationController?.view.addSubview(menuBarView)
    }
    
    func BlackScreenSetup() {
        blackScreen = UIView(frame: self.view.bounds)
        blackScreen.backgroundColor=UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden = true
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition = 99
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackScreen.addGestureRecognizer(tapGestRecognizer)
    }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.menuBarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.menuBarView.frame.height)
        }
    }
    
    @objc private func handleDropOff() {
        let nextViewController = DropOffLocationViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
        generator.impactOccurred()
        
    }
   
    @objc private func handleDestinationMap() {
        let nextViewController = DestinationMapViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
        generator.impactOccurred()
    }
    
    
    
   
    
    
}

extension HomeViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 15.0)
        
        self.mapView?.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}

extension HomeViewController: menuBarViewDelegate {
    func handleMenuToggle(forMenuOption: MenuOption?) {
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.menuBarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.menuBarView.frame.height)
            
             switch forMenuOption {
             case .GetARide?:
             let getRideController = HomeViewController()
             self.navigationController?.pushViewController(getRideController, animated: true)
             case .RideHistory?:
             let rideHistoryController = RideHistoryViewController()
             self.navigationController?.pushViewController(rideHistoryController, animated: false)
             case .Call?: // Alert with a number
             print("Call")
             case .DriveAndEarn?:
             let driveAndEarnController = DriveAndEarnViewController ()
             self.navigationController?.pushViewController(driveAndEarnController, animated: true)
             case .Help?:
             let helpController = HelpViewController ()
             self.navigationController?.pushViewController(helpController, animated: true)
             case .Settings?:
             let settingsController = SettingsViewController ()
             self.navigationController?.pushViewController(settingsController, animated: true)
          
              case .none:
                break
                
            }
        
    }
    
    
    
    }
}

extension HomeViewController: HeaderTableViewCellDelegate {
    func didSelectHeaderCell() {
        print("Help")
    }
    
    
}
