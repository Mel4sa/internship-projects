//
//  ViewController.swift
//  Calculator
//
//  Created by Melisa Şimşek on 9.07.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var calculatorWorkingsText: String = ""
        
    
    @IBOutlet weak var calculatorWorkings: UILabel!
 
    @IBOutlet weak var calculatorResult: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
 clearCalculator()
        
    }
    
    func clearCalculator() {
        calculatorWorkingsText = ""
        calculatorWorkings.text = calculatorWorkingsText
        calculatorResult.text = "0"
    }

    @IBAction func equalsButton(_ sender: UIButton) {
        let expression = NSExpression(format: calculatorWorkingsText)
         
         if let result = expression.expressionValue(with: nil, context: nil) as? Double {
             let resultString = formatResult(result: result)
             calculatorResult.text = resultString
         } else {
             calculatorResult.text = "Error"
         }
     }
         
     func formatResult(result: Double) -> String {
         if result.truncatingRemainder(dividingBy: 1) == 0 {
             return String(format: "%.0f", result) // Tam sayıysa ondalık göstermeden yaz
         } else {
             return String(format: "%.2f", result) // Ondalık varsa 2 basamakla yaz
         }
        
    }
    
    
    @IBAction func clearButton(_ sender: UIButton) {
        clearCalculator()
    }
    @IBAction func backButton(_ sender: UIButton) {
        if !calculatorWorkingsText.isEmpty {
            calculatorWorkingsText.removeLast()
            calculatorWorkings.text = calculatorWorkingsText
        }
        
    }
    
    func updateCalculatorWorkings(with text: String) {
        calculatorWorkingsText += text
        calculatorWorkings.text = calculatorWorkingsText
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        updateCalculatorWorkings(with: "%")
    }
    
    @IBAction func divideButton(_ sender: UIButton) {
        updateCalculatorWorkings(with: "/")
    }
    
    @IBAction func timesButton(_ sender: UIButton) {
        updateCalculatorWorkings(with: "*")
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        updateCalculatorWorkings(with: "-")
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        updateCalculatorWorkings(with: "+")
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        updateCalculatorWorkings(with: "/")
      
    }
    @IBAction func zeroTap(_ sender: Any) {
        updateCalculatorWorkings(with: "0")
    }
    
    @IBAction func oneTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "1")
    }
    
    @IBAction func twoTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "2")
    }
    @IBAction func threeTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "3")
    }
    
    @IBAction func fourTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "4")
    }
    
    @IBAction func fiveTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "5")
    }
    
    @IBAction func sixTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "6")
    }
    
    @IBAction func sevenTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "7")
    }
    
    @IBAction func eightTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "8")
    }
    
    @IBAction func nineTap(_ sender: UIButton) {
        updateCalculatorWorkings(with: "9")
    }
    
    
    
    
    
    
}

