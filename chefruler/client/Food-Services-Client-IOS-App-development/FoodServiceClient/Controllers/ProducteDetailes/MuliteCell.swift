//
//  MuliteCell.swift
//  FoodService
//
//  Created by index-ios on 3/20/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class MuliteCell: UITableViewCell {
    @IBOutlet weak var nameoflabel: UILabel!
    @IBOutlet weak var valueoflabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueoflabel.text="Lable".localized()
        
    }

   

}
