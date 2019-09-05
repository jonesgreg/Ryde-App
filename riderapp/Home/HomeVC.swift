//
//  HomePageViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 7/24/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
   
  
    // MARK: - Overriden function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [mapContainerView,destinationView,greetingTitle,whereToView,searchIcon,whereToButton,previousSelectionStackView,campusSelectionStackView,mapTitleImage,menuButton,menuButtonImage,navigationIcon,navigationIconImage].forEach { view.addSubview($0) }
   setupGoogleMaps()
    configureUI()
    constraintsLayout()
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
      
        
    }
    //MARK: Private functions
   
private var mapContainerView: UIView = {
        let view = UIView()
            view.backgroundColor = Colors.fleetGreen
            view.translatesAutoresizingMaskIntoConstraints = false
    
            return view
    }()
    
    private let destinationView: UIView = {
            let view =  UIView()
                view.layer.shadowColor = UIColor.black.cgColor;
                view.layer.shadowOpacity = 0.5;
                view.layer.shadowRadius  = 5;
                view.layer.shadowOffset  = CGSize(width :0, height :2)
                view.layer.masksToBounds = false;
                view.layer.cornerRadius  =  2.0;
                view.layer.borderWidth   = 0.0;
                view.backgroundColor     =  .white
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
    }()
    
  private let menuButton: UIButton = {
        let button = whiteCircleButton(type: .system)
    
    
            // button.addTarget(self, action: //#selector(handleNextPage), for: .touchUpInside)
       return button
    }()
    
    private let menuButtonImage: UIImageView = {
            let imageView = UIImageView(image:#imageLiteral(resourceName: "menu"))
                imageView.contentMode = .scaleAspectFit
                imageView.width(constant: 18)
                imageView.height(constant: 18)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
    }()
    
    private let mapTitleImage: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "fleetgreen"))
            imageView.contentMode = .scaleAspectFit
            imageView.width(constant: 55)
            imageView.height(constant: 55)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
    }()
    
  
    private let navigationIcon: UIButton = {
        let button = whiteCircleButton(type: .system)
            // button.addTarget(self, action: //#selector(handleNextPage), for: .touchUpInside)
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
        let attributedText = NSMutableAttributedString(string: "Good Evening, Gregory", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            attributedText.append(NSAttributedString(string: "\nWhere are you going tonight?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
            textView.attributedText = attributedText
            textView.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle("Enter your destination", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 18)
        button.setTitleColor(Colors.fleetGreen, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleDropOff), for: .touchUpInside)
        return button
    }()
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "round_search_black_36pt_2x"))
        imageView.contentMode = .scaleAspectFit
        imageView.width(constant: 24)
        imageView.height(constant: 24)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   
    private let previousLocationButton: UIButton = {
            let button = grayCircleButton(type: .system)
            let img = UIImage(named: "previouslocation")
            button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 26, left: 26, bottom: 26, right: 26)
           return button
    }()
    
    private let previousTextButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedText = NSMutableAttributedString(string: "Villiger Hall", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\n2401 Cardinal Ave Philadelphia, PA 19131", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratRegular, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleDestinationMap), for: .touchUpInside)
        
        return button
        
    }()
    
private let campusButton: UIButton = {
        let button = grayCircleButton(type: .system)
        let img = UIImage(named: "campus")
            button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 26, left: 26, bottom: 26, right: 26)
            return button
    }()
    
    private let campusTextButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedText = NSMutableAttributedString(string: "Saint Joseph's University", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\n5600 City Ave Philadelphia, PA 19131", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratRegular, size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
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
       
      mapContainerView.addSubview(mapView!)
      mapContainerView.addSubview(mapTitleImage)
      mapContainerView.addSubview(menuButton)
      mapContainerView.addSubview(menuButtonImage)
      mapContainerView.addSubview(navigationIcon)
      mapContainerView.addSubview(navigationIconImage)
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
    greetingTitle.anchor(top: destinationView.topAnchor, bottom: destinationView.bottomAnchor, leading: destinationView.leadingAnchor, trailing: destinationView.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 0, right: 0))
    whereToView.anchor(top: destinationView.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 70, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 60))
  whereToButton.anchor(top: whereToView.topAnchor, bottom: nil, leading: whereToView.leadingAnchor, trailing: whereToView.trailingAnchor, padding: .init(top: 12, left: 50, bottom: 0, right: 0))
    searchIcon.anchor(top: whereToView.topAnchor, bottom: nil, leading: whereToView.leadingAnchor, trailing: nil, padding: .init(top: 20, left: 16, bottom: 0, right: 0))
 previousSelectionStackView.topAnchor.constraint(equalTo: whereToView.bottomAnchor, constant: 15).isActive = true
   previousSelectionStackView.leadingAnchor.constraint(equalTo: whereToView.leadingAnchor, constant: 16).isActive = true
    previousSelectionStackView.trailingAnchor.constraint(equalTo: whereToView.trailingAnchor).isActive = true
    
    campusSelectionStackView.topAnchor.constraint(equalTo: previousSelectionStackView.bottomAnchor, constant: 15).isActive = true
    campusSelectionStackView.leadingAnchor.constraint(equalTo: previousSelectionStackView.leadingAnchor).isActive = true
   campusSelectionStackView.trailingAnchor.constraint(equalTo: previousSelectionStackView.trailingAnchor).isActive = true
   mapTitleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    mapTitleImage.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor).isActive = true
    menuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    menuButtonImage.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor).isActive = true
    menuButtonImage.centerXAnchor.constraint(equalTo: menuButton.centerXAnchor).isActive = true
    navigationIcon.bottomAnchor.constraint(equalTo: mapView!.bottomAnchor, constant: -20).isActive = true
    navigationIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    navigationIconImage.centerYAnchor.constraint(equalTo: navigationIcon.centerYAnchor).isActive = true
    navigationIconImage.centerXAnchor.constraint(equalTo: navigationIcon.centerXAnchor).isActive = true
    mapContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    mapContainerView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    mapContainerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.65).isActive = true
    mapView?.topAnchor.constraint(equalTo: mapContainerView.topAnchor).isActive = true
    mapView?.widthAnchor.constraint(equalTo: mapContainerView.widthAnchor).isActive = true
    mapView?.heightAnchor.constraint(equalTo: mapContainerView.heightAnchor).isActive = true
    destinationView.topAnchor.constraint(equalTo: mapContainerView.bottomAnchor).isActive = true
    destinationView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    destinationView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7).isActive = true
    
   }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - Selector
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
