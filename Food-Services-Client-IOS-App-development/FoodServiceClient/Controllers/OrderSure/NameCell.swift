//
//  NameCell.swift
//  FoodService
//
//  Created by index-ios on 4/11/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
