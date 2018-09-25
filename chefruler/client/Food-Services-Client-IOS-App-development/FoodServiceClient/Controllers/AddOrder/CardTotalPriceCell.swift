//
//  TotalPriceCell.swift
//  FoodService
//
//  Created by index-ios on 3/25/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class CardTotalPriceCell: UITableViewCell {

    @IBOutlet weak var Pricelable: UILabel!
    
    @IBOutlet weak var Totalpricelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Totalpricelabel.text="TotalPrice".localized()
        
        // Initialization code
    }

  

}
