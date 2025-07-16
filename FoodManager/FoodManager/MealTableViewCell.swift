//
//  MealTableViewCell.swift
//  FoodManager
//
//  Created by Melisa Şimşek on 16.07.2025.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
     @IBOutlet weak var nameLabel: UILabel!
     @IBOutlet weak var caloriesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
