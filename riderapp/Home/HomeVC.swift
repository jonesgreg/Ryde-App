import UIKit
import GoogleMaps

private let reuseIdentifer = "LocationCell"

class HomeViewController: UIViewController,UIGestureRecognizerDelegate {

    deinit {
          print("OS Reclaiming memory for this class")
      }

  

    //MARK: - Properties
    
    // Setting up Map View and Location
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
   
    // Slide Menu Bar
    var menuBarView: MenuViewController!
    var blackScreen: UIView!
    
    
    // Child classes inheriting properties from Home Class
    let destination = DestinationView()
    let selectVehicle = SelectVehicleViewController()
    let driverPickUp = DriverPickUpViewController()
   
 
    
  
    
    // Custom Height size for the subviews
    let customHeight:CGFloat = 300
    let destinationHeight: CGFloat = 405
    let driverPickUpCustomHeight: CGFloat = 300
    var cardHandleAreaHeight:CGFloat = 65
   
   
  
   
 
    // MARK: - Overriden function

    override func viewDidLoad() {
        super.viewDidLoad()
        MenuBarSetup()
       BlackScreenSetup()
       setupGoogleMaps()
       setupDestinationView()
       configureUI()
       constraintsLayout()
        
        
         
        
        
       
      }

override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
         showTabBarController()
         navigationIcon.isHidden = true
         backButton.isHidden = true
         warningView.isHidden = true
         warningText.isHidden = true
        
    
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       self.navigationController?.setNavigationBarHidden(false, animated: animated)
       
    }
 
    //MARK: Private functions
   func setupDestinationView() {
    
       // Set child
           addChild(self.destination)
      destination.didMove(toParent: self)
           destination.delegate = self
           destination.animateVehicleView = self
           view.addSubview(self.destination.view)
            destination.view.frame = CGRect(x: 0, y: self.view.frame.height - destinationHeight, width: self.view.bounds.width, height: destinationHeight)
  /* let mapInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 283, right: 0.0)
        mapView?.padding = mapInsets */
    let mapInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 315, right: 0.0)
           mapView?.padding = mapInsets
    
  }
    
  

 
 
    
    private let menuButton: UIButton = {
        let button = profileButton(type: .custom)
            button.addTarget(self, action: #selector(handleMenuAction), for: .touchUpInside)
            button.setImage(#imageLiteral(resourceName: "gregprofile"), for: .normal)
            button.tintColor = .black
          // for the menu button:  button.imageEdgeInsets = UIEdgeInsets(top: 38.0, left: 38.0, bottom: 38.0, right: 38.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 47.0, left: 47.0, bottom: 47.0, right: 47.0)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }()
    
    
     private let warningView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor;
       view.layer.shadowOpacity = 0.2;
        view.layer.shadowRadius  = 1;
        view.layer.shadowOffset  = CGSize(width :0, height :1)
        view.layer.masksToBounds = false;
        view.layer.cornerRadius  =  12;
        view.layer.borderWidth   = 0.0;
        view.backgroundColor     =  .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let warningText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Verify name, destination, and vehicle before getting into the vehicle", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 14) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
  

   
   private let navigationIcon: UIButton = {
    let button = whiteCircleButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "navigation"), for: .normal)
       button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 32.0, left: 32.0, bottom: 32.0, right: 32.0)
        button.addTarget(self, action: #selector(goToMyLocation), for: .touchUpInside)
      
        return button
    }()
    
    private let safetyMessageButton: UIButton = {
       let button = SafetyButton(type: .system)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setImage(#imageLiteral(resourceName: "warning"), for: .normal)
        button.tintColor =  .white
         button.imageEdgeInsets = UIEdgeInsets(top: 33.0, left: 33.0, bottom: 33.0, right: 33.0)
        //   button.imageEdgeInsets = UIEdgeInsets(top: 55.0, left: 55.0, bottom: 55.0, right: 55.0)
         //  button.addTarget(self, action: #selector(goToMyLocation), for: .touchUpInside)
         
           return button
       }()
    
   private let backButton: UIButton = {
         let backButton = whiteCircleButton(type: .system)
             backButton.setImage(#imageLiteral(resourceName: "direction_backwards"), for: .normal)
             backButton.tintColor = .black
             backButton.imageEdgeInsets = UIEdgeInsets(top: 35.0, left: 35.0, bottom: 35.0, right: 35.0)
          backButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            backButton.translatesAutoresizingMaskIntoConstraints = false
           return backButton
       }()

   

   private func setupGoogleMaps() {
    let camera = GMSCameraPosition.camera(withLatitude: 39.277444, longitude: -76.689768, zoom: 15)
     mapView = GMSMapView.map(withFrame: .zero, camera: camera)
     //   let mapInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 283, right: 0.0)
         //   mapView?.padding = mapInsets
     self.view.addSubview(mapView!)
     self.mapView?.isMyLocationEnabled = true
     self.locationManager.delegate = self // Fetch current location
     self.locationManager.startUpdatingLocation() //

    mapView?.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
    mapView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
    mapView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
    mapView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
    
    mapView?.addSubview(menuButton)
    mapView?.addSubview(backButton)
   
   
   mapView?.addSubview(safetyMessageButton)
    mapView?.addSubview(navigationIcon)
    mapView?.translatesAutoresizingMaskIntoConstraints = false
    mapView?.settings.consumesGesturesInView = true
    
    let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handleScreenPinch(sender:)))
        pinch.delegate = self
       mapView?.isUserInteractionEnabled = true
       mapView?.addGestureRecognizer(pinch)
     
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
  /*  view.addSubview(warningView)
    warningView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9).isActive = true
    warningView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10).isActive = true
    warningView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -40).isActive = true
    warningView.height(constant: 53)
    
  view.addSubview(warningText)
    warningText.anchor(top: warningView.topAnchor, bottom: warningView.bottomAnchor, leading: warningView.leadingAnchor, trailing: warningView.trailingAnchor, padding: .init(top: 3.5, left: 16, bottom: 0, right:16)) */
    
    
   
    menuButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
    menuButton.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
    
    backButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
      backButton.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
   navigationIcon.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
    navigationIcon.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -380).isActive = true
    
   safetyMessageButton.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
     safetyMessageButton.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -320).isActive = true
       
  
   }
    
    private func configureUI() {
    view.backgroundColor = .white

      }

// MARK: - Handlers

    @objc func handleMenuAction() {
        animateSlideMenu()
         hideTabBarController()
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
        generator.impactOccurred()
         

    
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
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
              blackScreen.addGestureRecognizer(tapGestRecognizer)
        
    }
   
  @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        blackScreen.isHidden = true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.menuBarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.menuBarView.frame.height)
           

        }
     showTabBarController()
    }


    
    @objc private func goToMyLocation() {
        guard let lat = self.mapView?.myLocation?.coordinate.latitude,
            let lng = self.mapView?.myLocation?.coordinate.longitude else { return }

        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 14.0)
        self.mapView!.animate(to: camera)
        navigationIcon.isHidden = true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
  
    
    @objc private func handleScreenPinch(sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
        navigationIcon.isHidden = false
         } else if sender.state == .changed {
            print("Gesture is changing")
         } else if sender.state == .ended {
            print("Gesture ended")
         }
    }
    
    

    
    @objc func cancelTrip() {
        
        // Hide Driver Pickup View
        UIView.animate(withDuration: 0.5, delay: 0.0,
                                     usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0,
                              options: .allowAnimatedContent, animations: {
                               self.driverPickUp.view.frame = CGRect(x: self.driverPickUp.view.frame.origin.x, y: self.driverPickUp.view.frame.origin.y + self.driverPickUp.view.frame.height, width: self.driverPickUp.view.frame.width, height: self.driverPickUp.view.frame.height)
                                
                          }) { (isFinished) in
                          
                              self.view.layoutIfNeeded()
                       }
    }
    
    @objc func handleDismiss() {
   
       // Hide the Selected Vehicle
        UIView.animate(withDuration: 0.5, delay: 0.0,
                              usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0,
                       options: .allowAnimatedContent, animations: {
                        self.selectVehicle.view.frame = CGRect(x: self.selectVehicle.view.frame.origin.x, y: self.selectVehicle.view.frame.origin.y + self.selectVehicle.view.frame.height, width: self.selectVehicle.view.frame.width, height: self.selectVehicle.view.frame.height)
                           self.backButton.isHidden = true
                           self.menuButton.isHidden = false
                           self.warningView.isHidden = true
                           self.warningText.isHidden = true
                   }) { (isFinished) in
                        // Show Menu Bar
                    self.view.layoutIfNeeded()
                        let mapInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 283, right: 0.0)
                        self.mapView?.padding = mapInsets
                       
                }
             
        
    }


}

extension HomeViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last

        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 16.0)

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
    func didSelectHeaderViewCell(Selected: Bool, UserHeader: HeaderViewCell) {
        print("Help")
    }
}


extension HomeViewController: SelectedVehicleDelegate {
    func handleHomeDissmial(SelectedVehicle: Int) {
        menuButton.isHidden = true
        backButton.isHidden = false
        warningText.isHidden = false
        warningView.isHidden = false
 
    }
}

extension HomeViewController:AnimateSelectVehicleDelegate {
    func handleAnimationSelectVehicle(animateVehicle: Int) {
    addChild(self.selectVehicle)
              selectVehicle.didMove(toParent: self)
               selectVehicle.animateDriverPickView = self
             
             view.addSubview(self.selectVehicle.view)
             selectVehicle.view.frame = CGRect(x: 0, y: self.view.frame.height - customHeight, width: self.view.bounds.width, height: self.customHeight)
          let mapInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 255, right: 0.0)
           self.mapView?.padding = mapInsets
        UIView.animate(withDuration: 0.5, delay: 0.0,
            usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0,
            options: .allowAnimatedContent, animations: {
                self.selectVehicle.view.frame = CGRect(x: self.selectVehicle.view.frame.origin.x, y: self.selectVehicle.view.frame.origin.y + 20, width: self.selectVehicle.view.frame.width, height: self.selectVehicle.view.frame.height)
               
        }) { (isFinished) in
            self.view.layoutIfNeeded()
            
    
    }
        // Hide the Destination View
            UIView.animate(withDuration: 0.5, delay: 0.0,
                                  usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0,
                           options: .allowAnimatedContent, animations: {
                            self.destination.view.frame = CGRect(x: self.destination.view.frame.origin.x, y: self.destination.view.frame.origin.y + self.destination.view.frame.height, width: self.destination.view.frame.width, height: self.destination.view.frame.height)
                             
                       }) { (isFinished) in
                            // Show Menu Bar
                             
                     
                           self.view.layoutIfNeeded()
                    }
                 
    
    }
}

extension HomeViewController: AnimateDriverPickUpDelegate {
    func handleAnimationDriverPick() {
        print("test")
     addChild(self.driverPickUp)
                   driverPickUp.didMove(toParent: self)
        view.addSubview(self.driverPickUp.view)
                  selectVehicle.view.frame = CGRect(x: 0, y: self.view.frame.height - customHeight, width: self.view.bounds.width, height: self.customHeight)
       
        let mapInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 215, right: 0.0)
                  self.mapView?.padding = mapInsets
         
        UIView.animate(withDuration: 0.5, delay: 0.0,
                usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0,
                options: .allowAnimatedContent, animations: {
                    self.driverPickUp.view.frame = CGRect(x: self.driverPickUp.view.frame.origin.x, y: self.driverPickUp.view.frame.origin.y + 20, width: self.driverPickUp.view.frame.width, height: self.driverPickUp.view.frame.height)
                   
            }) { (isFinished) in
                self.view.layoutIfNeeded()
                
        
        }
       
       // Hide the Selected Vehicle
        UIView.animate(withDuration: 0.5, delay: 0.0,
                              usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0,
                       options: .allowAnimatedContent, animations: {
                        self.selectVehicle.view.frame = CGRect(x: self.selectVehicle.view.frame.origin.x, y: self.selectVehicle.view.frame.origin.y + self.selectVehicle.view.frame.height, width: self.selectVehicle.view.frame.width, height: self.selectVehicle.view.frame.height)
                         
                   }) { (isFinished) in
                        // Show Menu Bar
                    self.backButton.isHidden = true
                    self.menuButton.isHidden = false
                       self.view.layoutIfNeeded()
                } 
    }
}

extension HomeViewController: dismissDriverPickUpView {
    func handleDismissDriverPickUp() {
        print("Test")
    }
    
    
}


