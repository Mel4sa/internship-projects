//
//  ConverterViewController.swift
//  ExTrack
//
//  Created by Melisa Şimşek on 24.07.2025.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    

    var rates: [String: Double] = [:]
        var currencies: [String] = []

        var selectedFrom: String = "USD"
        var selectedTo: String = "TRY"

        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Döviz Çevirici"

            fromPicker.dataSource = self
            fromPicker.delegate = self
            toPicker.dataSource = self
            toPicker.delegate = self
            amountTextField.delegate = self
            amountTextField.keyboardType = .numbersAndPunctuation

            loadRatesFromCache()
        }

        func loadRatesFromCache() {
            if let cached = CacheManager.shared.loadRates() {
                self.rates = cached.rates
                self.currencies = rates.keys.sorted()

                DispatchQueue.main.async {
                    if let fromIndex = self.currencies.firstIndex(of: "USD") {
                        self.fromPicker.selectRow(fromIndex, inComponent: 0, animated: false)
                        self.selectedFrom = self.currencies[fromIndex]
                    }

                    if let toIndex = self.currencies.firstIndex(of: "TRY") {
                        self.toPicker.selectRow(toIndex, inComponent: 0, animated: false)
                        self.selectedTo = self.currencies[toIndex]
                    }
                }
            } else {
                resultLabel.text = "Önce liste ekranında veriyi yükleyin"
            }
        }
            
    @IBAction func convertButtonTapped(_ sender: UIButton) {
            guard let amountText = amountTextField.text,
                  let amount = Double(amountText),
                  let fromRate = rates[selectedFrom],
                  let toRate = rates[selectedTo] else {
                resultLabel.text = "Geçerli değer girin"
                return
            }

            let usdAmount = amount / fromRate
           let convertedAmount = usdAmount * toRate
            resultLabel.text = "\(String(format: "%.2f", amount)) \(selectedFrom) = \(String(format: "%.2f", convertedAmount)) \(selectedTo)"
        }
    }

    // MARK: - UIPickerViewDataSource & Delegate
    extension ConverterViewController: UIPickerViewDataSource, UIPickerViewDelegate {

        func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return currencies.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return currencies[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView == fromPicker {
                selectedFrom = currencies[row]
            } else {
                selectedTo = currencies[row]
            }
        }
    }

    // MARK: - UITextFieldDelegate
    extension ConverterViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            amountTextField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
    }

