//
//  CountryCodeListController.swift
//  riderapp
//
//  Created by Gregory Jones on 7/17/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit


protocol countryPickerProtocol: class {
    func didPickCountry(model: Country)
}

class CountryCodeListController: UIViewController{
    
    
    //MARK: - Properties
    let countries: Countries
    public weak var delegate: countryPickerProtocol?

   
    
   //MARK: - Overriden function
    
    init(countries: Countries) {
        self.countries = countries
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(countryListTableView)
        configureNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        //self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
 
    // MARK: - table view
    
   private lazy var countryListTableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        let nib:UINib = UINib(nibName: CountryCodeListCell.reuseIdentifier, bundle: nil) // might be an issue
        tableView.register(nib, forCellReuseIdentifier: CountryCodeListCell.reuseIdentifier) // might be an issue
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
private func configureNavigationController() {
          navigationItem.title = "Select a country"
          navigationController?.navigationBar.isTranslucent = false
    let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(handlePreviousPage))
        closeButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: Fonts.gilroyMedium, size: 16)!,
        NSAttributedString.Key.foregroundColor : UIColor.black,
    ], for: .normal)
          closeButton.tintColor = .black
          self.navigationItem.rightBarButtonItem = closeButton
         let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
         navigationController?.navigationBar.titleTextAttributes = textAttributes
    self.navigationItem.setHidesBackButton(true, animated:true)
        
    }
    
    // MARK: - Selectors
    @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension CountryCodeListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countries.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        let key = countries.sections[section]
        return countries.metaData[key]?.count ?? 00
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countries.sections[section]
    }
   
   
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryCodeListCell = tableView.dequeueReusableCell(withIdentifier: CountryCodeListCell.reuseIdentifier, for: indexPath) as! CountryCodeListCell
       let sectionKey = countries.sections[indexPath.section]
        if let countries = countries.metaData[sectionKey] {
            let country: Country = countries[indexPath.row]
            cell.feedCountry(info: country)
    }
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return UITableView.automaticDimension
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionKey = countries.sections[indexPath.section]
        if let countries = countries.metaData[sectionKey] {
            let country:Country = countries[indexPath.row]
            self.delegate?.didPickCountry(model: country)
        }
        
        DispatchQueue.main.async {[weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
     }
  }
   






