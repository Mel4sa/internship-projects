//
//  ViewController.swift
//  ExTrack
//
//  Created by Melisa Şimşek on 24.07.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var rates: [(String, Double)] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Döviz Kurları"
            
            tableView.dataSource = self
            
            fetchData()
        }
        
        func fetchData() {
            ExchangeRateService.shared.fetchRates(base: "USD") { response in
                guard let response = response else { return }
                
                // Dictionary'i sıralı diziye dönüştürüyoruz
                self.rates = response.rates.sorted { $0.key < $1.key }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        // MARK: - TableView
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return rates.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RateCell", for: indexPath)
            let (currency, value) = rates[indexPath.row]
            cell.textLabel?.text = "\(currency): \(String(format: "%.2f", value))"
            return cell
        }
    }
