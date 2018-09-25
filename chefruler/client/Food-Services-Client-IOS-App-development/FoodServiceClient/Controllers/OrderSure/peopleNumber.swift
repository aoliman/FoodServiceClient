//
//  peopleNumber.swift
//  FoodService
//
//  Created by index-ios on 4/11/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class peopleNumber: UITableViewCell {

    @IBOutlet weak var peoplenumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var deliverydate: UILabel!
    @IBOutlet weak var PeopleNumberLabel: UILabel!
    @IBOutlet weak var cookernamelabel: UILabel!
    @IBOutlet weak var deliveryday: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       PeopleNumberLabel.text="People Number".localized()
       cookernamelabel.text="Cooker Name".localized()
       deliveryday.text="Delivery Day".localized()
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
