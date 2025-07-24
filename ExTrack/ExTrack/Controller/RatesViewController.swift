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

            // Pull-to-refresh
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshRates), for: .valueChanged)
            tableView.refreshControl = refreshControl

            loadCachedOrFetch()
        }

        func loadCachedOrFetch() {
            if let cached = CacheManager.shared.loadRates() {
                self.rates = cached.rates.sorted { $0.key < $1.key }
                DispatchQueue.main.async { self.tableView.reloadData() }
            } else {
                fetchData()
            }
        }

        @objc func refreshRates() {
            fetchData {
                DispatchQueue.main.async {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }

        func fetchData(completion: (() -> Void)? = nil) {
            ExchangeRateService.shared.fetchRates { response in
                guard let response = response else {
                    print("Veri alınamadı")
                    completion?()
                    return
                }

                CacheManager.shared.save(rates: response.rates, date: response.date)
                self.rates = response.rates.sorted { $0.key < $1.key }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    completion?()
                }
            }
        }

        // MARK: - UITableViewDataSource

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
