//
//  HomePageViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 7/24/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import GoogleMaps

private let reuseIdentifer = "LocationCell"

class HomeViewController: UIViewController{
    
    deinit {
          print("OS Reclaiming memory for this class")
      }
      
    let Dormlocations = [
           Location(image: "green_home",title: "LaFarge Residence Center", desc: "Dorm Hall", coordinate:  CLLocationCoordinate2D(latitude: 39.998940, longitude: -75.238962), location: "2425 Cardinal Ave"),
           Location(image:"green_home",title: "Sourin Residence Center", desc: "Dorm Hall",coordinate: CLLocationCoordinate2D(latitude: 39.993307, longitude: -75.240373), location: "2449 Cardinal Ave")]
    
    //MARK: - Properties
    
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
    var menuBarView: MenuViewController!
    var blackScreen: UIView!
    var tableView: UITableView!
    
  
 // MARK: - Overriden function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuBarSetup()
   BlackScreenSetup()
   setupGoogleMaps()
    configureUI()
   constraintsLayout()
   configureTableView()
   tableViewConstraints()
}
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
      self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tableView.deselectSelectedRow(animated: false)
        
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
                imageView.width(constant: 20)
                imageView.height(constant: 20)
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
        let attributedText = NSMutableAttributedString(string: "Nice to see you!", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyRegular, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\nWhere are you going?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size: 20) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
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
        button.titleLabel?.font = UIFont(name: Fonts.gilroyMedium, size: 15)
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
        let attributedText = NSMutableAttributedString(string: "Residence Hall", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\n2599 Cardinal Ave #2401, Philadelphia, PA 19131", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
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
   //  mapView?.addSubview(navigationIcon)
   //  mapView?.addSubview(navigationIconImage)
    mapView?.translatesAutoresizingMaskIntoConstraints = false
    self.mapView?.isMyLocationEnabled = true
      self.locationManager.delegate = self // Fetch current location
      self.locationManager.startUpdatingLocation() //
       
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
    

    // MAP Buttons
     
    menuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
    menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
     menuButtonImage.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor).isActive = true
     menuButtonImage.centerXAnchor.constraint(equalTo: menuButton.centerXAnchor).isActive = true 
    
  //  navigationIcon.bottomAnchor.constraint(equalTo: mapView!.bottomAnchor, constant: -20).isActive = true
 //   navigationIcon.trailingAnchor.constraint(equalTo: mapView!.trailingAnchor, constant: -20).isActive = true
  //  navigationIconImage.centerYAnchor.constraint(equalTo: navigationIcon.centerYAnchor).isActive = true
 //   navigationIconImage.centerXAnchor.constraint(equalTo: navigationIcon.centerXAnchor).isActive = true
   }
    private func configureUI() {
    view.backgroundColor = .white
        
      }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifer)
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
        tableView.topAnchor.constraint(equalTo: whereToView.bottomAnchor, constant: 15).isActive = true
       
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
            self.menuBarView.frame = CGRect(x:0, y:0, width: 250, height: self.menuBarView.frame.height)
            
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
    
    }
     func clearOnAppearance() {
       for indexPath in tableView.indexPathsForSelectedRows ?? [] {
           tableView.deselectRow(at: indexPath, animated: false)
        }
       }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        blackScreen.isHidden = true
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dormlocations.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! LocationCell
        
        let location = Dormlocations[indexPath.item]
        cell.hideSeparator()
        cell.location = location
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
             self.navigationController?.pushViewController(getRideController, animated: false)
             case .RideHistory?:
             let rideHistoryController = RideHistoryViewController()
             self.navigationController?.pushViewController(rideHistoryController, animated: false)
             case .Call?: // Alert with a number
             //  let emergencyAlert = EmergencyAlert()
              // self.present(emergencyAlert, animated: true)
                EmergencyAlert.instance.showAlert(title: "EMERGENCY ALERT", message: "Contact University Security or Office of Public Safety", alert: .call)
             case .Help?:
             let helpController = HelpViewController ()
             self.navigationController?.pushViewController(helpController, animated: false)
             case .Settings?:
             let settingsController = SettingsViewController ()
             self.navigationController?.pushViewController(settingsController, animated: false)
          
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


  
