//
//  BtnSure.swift
//  FoodService
//
//  Created by index-ios on 4/11/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class BtnSure: UITableViewCell {

    @IBOutlet weak var Btncompleteorder: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        Btncompleteorder.layer.cornerRadius=10
        Btncompleteorder.setTitle("Compelete Order".localized(), for: .normal)
    }

    

}
