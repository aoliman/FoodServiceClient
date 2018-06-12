//
//  Priceforperson.swift
//  FoodService
//
//  Created by index-ios on 4/10/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class Priceforperson: UITableViewCell {

    @IBOutlet weak var pricepersonlabel: UILabel!
    @IBOutlet weak var PriceforPerson: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     pricepersonlabel.text="Price For One Persone".localized()
        
        
    }

    

}
