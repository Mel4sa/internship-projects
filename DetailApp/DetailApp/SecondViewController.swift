//
//  SecondViewController.swift
//  DetailApp
//
//  Created by Melisa Şimşek on 14.07.2025.
//

import UIKit

class SecondViewController: UIViewController {
    
 

        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var descriptionTextView: UITextView!
        @IBOutlet weak var favoriteSwitch: UISwitch!

    var productTitle: String?
        override func viewDidLoad() {
            super.viewDidLoad()
            titleLabel.text = productTitle
                    descriptionTextView.text = "Swift programlama dili hakkında detaylı açıklama buraya gelecek."
        }

     
    
}

