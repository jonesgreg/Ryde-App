//
//  DestinationView.swift
//  riderapp
//
//  Created by Gregory Jones on 10/15/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import GoogleMaps

private let reuseIdentifer = "LocationCell"

class DestinationView: UIViewController {

    
    // MARK: - Properties
       
       
        var tableView: UITableView!
        
        weak var delegate: SelectedVehicleDelegate?
        weak var animateVehicleView: AnimateSelectVehicleDelegate?
        let cardHeight: CGFloat = 300
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        constraintsLayout()
        configureTableView()
        tableViewConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
    }

    
     var  Dormlocations = [
            Location(image: "green_home",title: "LaFarge Residence Center", desc: "Dorm Hall", coordinate:  CLLocationCoordinate2D(latitude: 39.998940, longitude: -75.238962), location: "2425 Cardinal Ave"),
            Location(image:"green_home",title: "Sourin Residence Center", desc: "Dorm Hall",coordinate: CLLocationCoordinate2D(latitude: 39.993307, longitude: -75.240373), location: "2449 Cardinal Ave")]
    
   
    
    
    // MARK: - Private functions
   
        
      /*      let destinationView: UIView = {
            let view =  UIView()
                view.layer.shadowColor = UIColor.black.cgColor;
                view.layer.shadowOpacity = 0.5;
                view.layer.shadowRadius  = 2.0;
                view.layer.shadowOffset  = CGSize(width :0, height :1)
                view.layer.masksToBounds = false;
                view.layer.cornerRadius  =  14;
                view.backgroundColor     =  .white
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
    }() */
    
    let destinationView: UIView = {
               let view =  UIView()
                   view.layer.shadowColor = UIColor.black.cgColor;
                   view.layer.shadowOpacity = 0.5;
                   view.layer.shadowRadius  = 2.0;
                   view.layer.shadowOffset  = CGSize(width :0, height :1)
                   view.layer.masksToBounds = false;
                 //  view.layer.cornerRadius  =  14;
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
    
          let navigationIcon: UIButton = {
           let button = whiteCircleButton(type: .system)
           return button
           }()
     
          let navigationIconImage: UIImageView = {
          let imageView = UIImageView(image:#imageLiteral(resourceName: "navigation"))
              imageView.contentMode = .scaleAspectFit
              imageView.width(constant: 22)
              imageView.height(constant: 22)
              imageView.translatesAutoresizingMaskIntoConstraints = false
              return imageView
          }()
    
   /*    let greetingTitle: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Nice to see you!", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyRegular, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            attributedText.append(NSAttributedString(string: "\nWhere are you going?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size: 20) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.textAlignment = .left
       textView.isEditable = false
       textView.isScrollEnabled = false
            textView.backgroundColor = .clear
      return textView
    }() */
    
    let greetingTitle: UITextView = {
           let textView = UITextView()
           let attributedText = NSMutableAttributedString(string: "Nice to see you!", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 15) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
              attributedText.append(NSAttributedString(string: "\nWhere are you going?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size: 20) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
           textView.attributedText = attributedText
           textView.translatesAutoresizingMaskIntoConstraints = true
           textView.textAlignment = .left
          textView.isEditable = false
          textView.isScrollEnabled = false
               textView.backgroundColor = .clear
         return textView
       }()
   
 /*   let whereToView: UIView = {
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
        return view
    }() */
    
    let whereToView: UIView = {
    let view = UIView()
    view.layer.shadowColor = UIColor.black.cgColor;
   // view.layer.shadowOpacity = 0.3;
    view.layer.shadowRadius  = 2;
    view.layer.shadowOffset  = CGSize(width :0, height :1)
    view.layer.masksToBounds = false;
   // view.layer.cornerRadius  =  12;
    view.layer.borderWidth   = 0.0;
    view.backgroundColor     =  Colors.lighterGrey
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    
   /* let whereToButton: UIButton = {
           let button = UIButton(type: .custom)
           button.setTitle("Search your destination", for: .normal)
           button.titleLabel?.font = UIFont(name: Fonts.gilroyMedium, size: 15)
           button.setTitleColor(Colors.darkGreyColor, for: .normal)
           button.contentHorizontalAlignment = .left
           button.addTarget(self, action: #selector(handleDropOff), for: .touchUpInside)
           return button
       }() */
    
    let whereToButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Search your location", for: .normal)
    button.titleLabel?.font = UIFont(name: Fonts.gilroyMedium, size: 18)
        button.setTitleColor(.black, for: .normal)
    button.contentHorizontalAlignment = .left
    button.addTarget(self, action: #selector(handleDropOff), for: .touchUpInside)
    return button
    }()
   
    
   /* let searchIcon: UIImageView = {
           let imageView = UIImageView(image:#imageLiteral(resourceName: "seachicon"))
           imageView.contentMode = .scaleAspectFit
           imageView.width(constant: 20)
           imageView.height(constant: 20)
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }() */
    
    let searchIcon: UIImageView = {
              let imageView = UIImageView(image:#imageLiteral(resourceName: "Search"))
              imageView.contentMode = .scaleAspectFit
              imageView.width(constant: 22)
              imageView.height(constant: 22)
              imageView.translatesAutoresizingMaskIntoConstraints = false
              return imageView
          }()
   
    let campusButton: UIButton = {
        let button = greenCircleButton(type: .system)
        let img = UIImage(named: "campus")
            button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 26.5, left: 26.5, bottom: 26.5, right: 26.5)
            return button
    }()
    

     
    func setupView() {
       
        self.view.addSubview(destinationView)
        self.view.addSubview(handler)
        self.view.addSubview(greetingTitle)
        self.view.addSubview(whereToView)
        self.view.addSubview(whereToButton)
        self.view.addSubview(searchIcon)
       
    }
    
 
    
    private func constraintsLayout() {
        view.addSubview(destinationView)
        destinationView.translatesAutoresizingMaskIntoConstraints = false
        destinationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 33).isActive = true
        destinationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        destinationView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        destinationView.height(constant: 330)
        
     
        
    
    
   /*     view.addSubview(handler)
        handler.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 10).isActive = true
        handler.centerXAnchor.constraint(equalTo: destinationView.centerXAnchor).isActive = true
        handler.width(constant: 65)
        handler.height(constant: 4) */
          

        view.addSubview(greetingTitle)
        greetingTitle.anchor(top: destinationView.topAnchor, bottom: destinationView.bottomAnchor, leading: destinationView.leadingAnchor, trailing: nil, padding: .init(top: 15, left: 16, bottom: 0, right: 0))
       
    
        view.addSubview(whereToView)
        whereToView.anchor(top: destinationView.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 16, bottom: 50, right: 16), size: .init(width: 0, height: 50))
      
      view.addSubview(whereToButton)
       whereToButton.anchor(top: whereToView.topAnchor, bottom: nil, leading: whereToView.leadingAnchor, trailing: whereToView.trailingAnchor, padding: .init(top: 8, left: 50, bottom: 0, right: 0))
       
        view.addSubview(searchIcon)
       searchIcon.anchor(top: whereToView.topAnchor, bottom: nil, leading: whereToView.leadingAnchor, trailing: nil, padding: .init(top: 15, left: 16, bottom: 0, right: 0))
      
       
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
           tableView.reloadData()
       }
       func tableViewConstraints() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
           tableView.topAnchor.constraint(equalTo: whereToView.bottomAnchor, constant: 5).isActive = true
          
       }
    
 
   
    @objc private func handleDropOff() {
           let nextViewController = DropOffLocationViewController()
           self.navigationController?.pushViewController(nextViewController, animated: false)
        
    }
  }

extension DestinationView: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return Dormlocations.count
       }
      
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! LocationCell
           
           let location = Dormlocations[indexPath.item]
           cell.hideSeparator()
           cell.location = location
          
           // Change selection style color
              let backgroundView = UIView()
                  backgroundView.backgroundColor = Colors.mediumGreyColor
                 cell.selectedBackgroundView = backgroundView
           return cell
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 70
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
       //Handle Dismissal of each design and animate selected Vehicle
        delegate?.handleHomeDissmial(SelectedVehicle: indexPath.row)
        animateVehicleView?.handleAnimationSelectVehicle(animateVehicle: indexPath.row)
    }
    
   
       
    
}



