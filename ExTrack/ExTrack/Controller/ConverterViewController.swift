//
//  ConverterViewController.swift
//  ExTrack
//
//  Created by Melisa Şimşek on 24.07.2025.
//

import UIKit

class ConverterViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!

    var currencies: [String] = []
    var selectedCurrency: String = "USD"
    var rates: [String: Double] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kur Çevirici"
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        loadRates()
    }

    func loadRates() {
        if let cached = CacheManager.shared.loadRates() {
            self.rates = cached.rates
            self.currencies = Array(cached.rates.keys).sorted()
            currencyPicker.reloadAllComponents()
        }
    }

    @IBAction func convertTapped(_ sender: UIButton) {
        guard let amountStr = amountTextField.text,
              let amount = Double(amountStr),
              let rate = rates[selectedCurrency] else {
            resultLabel.text = "Geçersiz giriş"
            return
        }

        let result = amount * rate
        resultLabel.text = "\(amount) EUR = \(String(format: "%.2f", result)) \(selectedCurrency)"
    }
}

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencies[row]
    }
}
