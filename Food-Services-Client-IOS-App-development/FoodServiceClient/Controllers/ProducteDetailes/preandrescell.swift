//
//  preandrescell.swift
//  FoodService
//
//  Created by index-ios on 3/19/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class preandrescell: UITableViewCell {
    @IBOutlet weak var pre: UILabel!
    @IBOutlet weak var res: UILabel!
    
    @IBOutlet weak var Preparation: UILabel!
    
    @IBOutlet weak var ReVerse: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Preparation.text="Preparation Duration".localized()
        ReVerse.text="Reservation Time".localized()
        pre.text="Lable".localized()
        res.text="Lable".localized()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
