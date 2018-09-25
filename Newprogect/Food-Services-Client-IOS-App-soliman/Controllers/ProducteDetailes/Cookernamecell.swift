//
//  Cookernamecell.swift
//  FoodService
//
//  Created by index-ios on 3/20/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class Cookernamecell: UITableViewCell {

    @IBOutlet weak var CookerNamelabel: UILabel!
    @IBOutlet weak var Addmoreproduct: UIButton!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Addmoreproduct.setTitle("more".localized(), for: .normal)
        CookerNamelabel.text="Cooker Name".localized()
    
    }

  
    @IBAction func morebtnAction(_ sender: Any) {
    }
    
}
