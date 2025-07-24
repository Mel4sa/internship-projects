import UIKit

class RatesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var allRates: [(String, Double)] = []
       var filteredRates: [(String, Double)] = []

       override func viewDidLoad() {
           super.viewDidLoad()
           title = "Döviz Kurları"
           
           tableView.dataSource = self
           searchBar.delegate = self
           
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action: #selector(refreshRates), for: .valueChanged)
           tableView.refreshControl = refreshControl
           loadCachedOrFetch()
       }

       func loadCachedOrFetch() {
           if let cached = CacheManager.shared.loadRates() {
               print("Cache'den veri yüklendi: \(cached.date)")
               self.allRates = cached.rates.sorted { $0.key < $1.key }
               self.filteredRates = self.allRates
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           } else {
               print("Cache bulunamadı. API'den veri çekiliyor...")
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

               // Cache'e kaydet
               CacheManager.shared.save(rates: response.rates, date: response.date)

               self.allRates = response.rates.sorted { $0.key < $1.key }
               self.filteredRates = self.allRates

               DispatchQueue.main.async {
                   self.tableView.reloadData()
                   completion?()
               }
           }
       }
   }

   // MARK: - UITableViewDataSource
   extension RatesViewController: UITableViewDataSource {

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return filteredRates.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let (currency, value) = filteredRates[indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "RateCell", for: indexPath)
           cell.textLabel?.text = "\(currency): \(String(format: "%.2f", value))"
           return cell
       }
   }

   // MARK: - UISearchBarDelegate
   extension RatesViewController: UISearchBarDelegate {

       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText.isEmpty {
               filteredRates = allRates
           } else {
               filteredRates = allRates.filter { $0.0.lowercased().contains(searchText.lowercased()) }
           }
           tableView.reloadData()
       }

       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
       }
   }
