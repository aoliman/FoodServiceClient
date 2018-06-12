//
//  Totalpricepartycooker.swift
//  FoodService
//
//  Created by index-ios on 4/11/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class Totalpricepartycooker: UITableViewCell {
    @IBOutlet weak var Totalprice: UILabel!
    
    @IBOutlet weak var allpeicelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       allpeicelabel.text="TotalPrice".localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
