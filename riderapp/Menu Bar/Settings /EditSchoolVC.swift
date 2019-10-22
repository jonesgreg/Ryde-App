//
//  EditSchoolVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/27/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import GoogleMaps

private let reuseIdentifer = "LocationCell"

class EditSchoolViewController: UIViewController {
    
    let Dormlocations = [
        Location(image: "green_home",title: "LaFarge Residence Center", desc: "Dorm Halll", coordinate:  CLLocationCoordinate2D(latitude: 39.998940, longitude: -75.238962), location: "2425 Cardinal Ave"),
        Location(image:"green_home",title: "Sourin Residence Center", desc: "Dorm Hall",coordinate: CLLocationCoordinate2D(latitude: 39.993307, longitude: -75.240373), location: "2449 Cardinal Ave"),
        Location(image:"green_home",title: "McShain Residence Center", desc: "Dorm Hall", coordinate: CLLocationCoordinate2D(latitude: 39.995423, longitude: -75.240397), location: "333 W.City Ave"),
        Location(image:"green_home",title: "Villiger Residence Center", desc: "Dorm Hall", coordinate: CLLocationCoordinate2D(latitude: 39.993682, longitude:  -75.240787), location: "2525 Cardinal Ave"),
        Location(image:"green_home",title: "Quirk Hall", desc: "Dorm Hall",coordinate: CLLocationCoordinate2D(latitude: 39.998535, longitude:-75.239560), location: "2449 Cardinal Ave"),
        Location(image:"green_home",title: "St.Albert's Hall", desc: "Dorm Hall", coordinate: CLLocationCoordinate2D(latitude: 40.002363, longitude: -75.240681), location: "40 Lapsley Lane") ]
    
        //MARK: - Properties
    var tableView: UITableView!
    var searchBar: UISearchBar!
 
    //MARK: - Override functions
       
       override func viewDidLoad() {
           super.viewDidLoad()
           [schoolView, schoolIcon, schoolInput].forEach { view.addSubview($0) }
           configureNavigationBar()
           configureUI()
           schoolInput.delegate = self
         // configureTableView()
        //  tableViewConstraints()
           ConstraintsLayout()
    
                
      
       }
       override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
        schoolInput.becomeFirstResponder()
             
       }
       
       //MARK - Private functions

       private func configureUI() {
           view.backgroundColor = .white
        
       }
    
       private func configureNavigationBar() {
           navigationItem.title = "Add School"
           navigationController?.navigationBar.isTranslucent = false
          let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
          navigationController?.navigationBar.titleTextAttributes = textAttributes
          navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(handlePreviousPage), imageName: "trash")
       // Custom Back Button
              let backButton = UIButton(type: .system)
              backButton.setBackgroundImage(#imageLiteral(resourceName: "backarrow"), for:.normal)
              backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
              backButton.width(constant: 20)
              backButton.height(constant: 20)
              self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
       }
    private let schoolView: UIView = {
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
    
    
          private let schoolInput: UITextField = {
              let textField = searchLocation()
              textField.attributedPlaceholder = NSAttributedString(string: "Enter Address", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                  textField.textColor = UIColor.black
                  textField.textAlignment = .left
              
                  return textField
          }()
        
           
           private let schoolIcon: UIImageView = {
               let iv = UIImageView(image: #imageLiteral(resourceName: "setting_school"))
               iv.contentMode = .scaleAspectFit
               iv.width(constant: 22)
               iv.height(constant: 22)
               iv.translatesAutoresizingMaskIntoConstraints = false
               return iv
               
           }()
       
       private func ConstraintsLayout() {
            schoolView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 55))
       
        schoolIcon.anchor(top: schoolView.topAnchor, bottom: nil, leading: schoolView.leadingAnchor, trailing: nil, padding: .init(top: 15, left: 13, bottom: 0, right: 0))
           
        schoolInput.anchor(top: schoolView.topAnchor, bottom: schoolView.bottomAnchor, leading: schoolIcon.trailingAnchor, trailing: schoolView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
           
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
    }
       
       // MARK: - Selectors
       @objc private func handlePreviousPage() {
           self.navigationController?.popViewController(animated: false)
           
       }
       
       // MARK: - Selectors
          @objc private func saveToggle() {
           
          }
}

extension EditSchoolViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dormlocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! LocationCell
        
        let location = Dormlocations[indexPath.row]
        cell.hideSeparator()
        cell.location = location
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
extension EditSchoolViewController: UITextFieldDelegate {
    // Stop Editing on Return Key Tap
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            
        }
      private func textFieldShouldReturn(textField: UITextField!) -> Bool {
          textField.resignFirstResponder()
          return true
      }
}

