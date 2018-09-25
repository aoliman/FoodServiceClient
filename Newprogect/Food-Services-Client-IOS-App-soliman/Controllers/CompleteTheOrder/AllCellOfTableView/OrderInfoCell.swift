//
//  OrderInfo.swift
//  FoodService
//
//  Created by index-ios on 3/14/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class OrderInfoCell: UITableViewCell {

    @IBOutlet weak var PriceLable: UILabel!
    @IBOutlet weak var QuantityLable: UILabel!
    @IBOutlet weak var NameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

}
