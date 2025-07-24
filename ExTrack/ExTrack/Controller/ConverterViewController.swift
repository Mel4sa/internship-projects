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
            amountTextField.keyboardType = .decimalPad

            loadRatesFromCache()
        }

        func loadRatesFromCache() {
            if let cached = CacheManager.shared.loadRates() {
                self.rates = cached.rates
                self.currencies = rates.keys.sorted()
                
                if let fromIndex = currencies.firstIndex(of: "USD") {
                    fromPicker.selectRow(fromIndex, inComponent: 0, animated: false)
                }
                if let toIndex = currencies.firstIndex(of: "TRY") {
                    toPicker.selectRow(toIndex, inComponent: 0, animated: false)
                }

                selectedFrom = "USD"
                selectedTo = "TRY"
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
    }
