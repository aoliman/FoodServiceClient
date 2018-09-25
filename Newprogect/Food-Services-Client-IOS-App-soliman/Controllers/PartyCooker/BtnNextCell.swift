//
//  BtnNextCell.swift
//  FoodService
//
//  Created by index-ios on 4/9/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class BtnNextCell: UITableViewCell {

    @IBOutlet weak var BtnNext: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        BtnNext.setTitle("Next".localized(), for: .normal)
        // Initialization code
    }

  

}
