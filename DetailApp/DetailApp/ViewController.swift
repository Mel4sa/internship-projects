//
//  ViewController.swift
//  DetailApp
//
//  Created by Melisa Şimşek on 14.07.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func detailButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toSecondVC" {
               let destinationVC = segue.destination as! SecondViewController
               destinationVC.productTitle = textLabel.text
           }
       }
    
}

