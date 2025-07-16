//
//  ViewController.swift
//  FoodManager
//
//  Created by Melisa Şimşek on 14.07.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var meals: [Meal] = [] // listedeki veriler

        override func viewDidLoad() {
            super.viewDidLoad()

            tableView.delegate = self
            tableView.dataSource = self
        }

        // TableView Satır Sayısı
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return meals.count
        }

        // TableView Hücre İçeriği
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
            let meal = meals[indexPath.row]
            cell.textLabel?.text = meal.name
            cell.detailTextLabel?.text = "\(meal.calories) kcal"
            return cell
        }
    @IBAction func addMealTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
                 let calories = caloriesTextField.text, !calories.isEmpty else {
               return
           }

           let newMeal = Meal(name: name, calories: calories)
           meals.append(newMeal)

           tableView.reloadData()

           nameTextField.text = ""
           caloriesTextField.text = ""
    }


}

