//
//  ViewController.swift
//  FoodManager
//
//  Created by Melisa Şimşek on 14.07.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var meals: [Meal] = []
    var filteredMeals: [Meal] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadMeals()
        searchBar.delegate = self
    }
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredMeals.removeAll()
        } else {
            isSearching = true
            filteredMeals = meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    // TableView Satır Sayısı
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMeals.count : meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal = isSearching ? filteredMeals[indexPath.row] : meals[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealTableViewCell
        cell.nameLabel.text = meal.name
        cell.caloriesLabel.text = "\(meal.calories) kcal"
        return cell
    }
    
    // Kaydırarak Silme 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // GÜNCELLE
        let editAction = UIContextualAction(style: .normal, title: "Güncelle") { (_, _, completionHandler) in
            let meal = self.meals[indexPath.row]
            
            // Seçilen yemeği inputlara yerleştirme
            self.nameTextField.text = meal.name
            self.caloriesTextField.text = meal.calories
            
            // Listeden geçici olarak kaldırma
            self.meals.remove(at: indexPath.row)
            self.saveMeals()
            self.tableView.reloadData()
            
            completionHandler(true)
        }
        editAction.backgroundColor = .systemOrange

        // SİL
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (_, _, completionHandler) in
            self.meals.remove(at: indexPath.row)
            self.saveMeals()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }

        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return config
    }
    
    @IBAction func addMealTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
                showAlert(message: "Lütfen yemek adını girin.")
                return
            }
            
            guard let calories = caloriesTextField.text, !calories.isEmpty else {
                showAlert(message: "Lütfen kalori bilgisini girin.")
                return
            }
            
            let letters = CharacterSet.letters
            if name.rangeOfCharacter(from: letters.inverted) != nil {
                showAlert(message: "Yemek adı sadece harf içermelidir.")
                return
            }
            
            if Int(calories) == nil {
                showAlert(message: "Kalori sadece sayı olmalıdır.")
                return
            }

            let newMeal = Meal(name: name, calories: calories)
            meals.append(newMeal)
            meals.sort {
                (Int($0.calories) ?? 0) > (Int($1.calories) ?? 0)
            }
            saveMeals()
            tableView.reloadData()
            
            nameTextField.text = ""
            caloriesTextField.text = ""
        
    }
    
    // VERİYİ KAYDET
    func saveMeals() {
        if let encoded = try? JSONEncoder().encode(meals) {
            UserDefaults.standard.set(encoded, forKey: "meals")
        }
    }
    
    // VERİYİ YÜKLE
    func loadMeals() {
        if let savedData = UserDefaults.standard.data(forKey: "meals"),
           let decoded = try? JSONDecoder().decode([Meal].self, from: savedData) {
            meals = decoded.sorted {
                (Int($0.calories) ?? 0) > (Int($1.calories) ?? 0)
            }
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

