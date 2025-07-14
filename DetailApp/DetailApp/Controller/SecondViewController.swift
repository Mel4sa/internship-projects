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
       

    var productTitle: String?
        var productDescription: String?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        descriptionTextView.text = productDescription
        titleLabel.text = productTitle
    }
     
    
}

