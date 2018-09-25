//
//  CookerNameCell.swift
//  FoodService
//
//  Created by index-ios on 3/25/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class CookerNameCell: UITableViewCell {
    @IBOutlet weak var Cookernamelable: UILabel!
    @IBOutlet weak var preparationtimelabel: UILabel!
    
    @IBOutlet weak var preduration: UILabel!
    @IBOutlet weak var Cookername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Cookername.text="Cooker Name".localized()
        preduration.text="Preparation Duration".localized()
       
        // Initialization code
    }

   
}
