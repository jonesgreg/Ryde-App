//
//  CountryPickerViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 7/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class CountryPickerViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    var listOfCountries = [Country]()
   
   
    override func viewDidLoad() {
        downloadJsonLocalFile()
        setupTableView()
        
    }
    
    private func downloadJsonLocalFile() {
        do {
        guard let url = Bundle.main.url(forResource:"countries", withExtension: "json") else { return }
        
            let data = try Data(contentsOf: url)
            let country = try JSONDecoder().decode([Country].self, from: data)
            self.listOfCountries = country
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
      }
        catch let jsonError {
            print("Error serializing json:", jsonError)
        }
        
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CountryPickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCountries.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
            let country: Country
                country = listOfCountries[indexPath.row]
        
                cell.countryName.text = country.name
                cell.dialLabel.text = country.dial_code
        
                let imageString = country.code
                let imagePath = "CountryPicker.bundle/\(imageString).png"
                cell.flagImage.image = UIImage(named: imagePath)
                return cell
        
    }
    
   
    
    
    
}
