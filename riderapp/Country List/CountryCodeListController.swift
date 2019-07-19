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
class CountryCodeListController: UIViewController {
    
    // MARK - table view
    
    lazy var countryListTableView: UITableView = {
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
    
    let countries: Countries
    
    
    //Mark - Overriden function
    
    init(countries: Countries) {
        self.countries = countries
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a Country"
        view.addSubview(countryListTableView)
    }
    
    private func customizingNavigationItem() {
        // TO DO
    }
}

extension CountryCodeListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countries.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = countries.sections[section]
        return countries.metaData[key]?.count ?? 0
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
   
   
    
    }

    
    

