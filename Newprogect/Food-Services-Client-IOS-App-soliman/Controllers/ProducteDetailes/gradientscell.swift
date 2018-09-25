//
//  gradientscell.swift
//  FoodService
//
//  Created by index-ios on 3/19/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class gradientscell: UITableViewCell {

    @IBOutlet weak var gradiantelabel: UILabel!
    @IBOutlet weak var gradient: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradiantelabel.text="Gradients".localized()
        gradient.text="Lable".localized()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
