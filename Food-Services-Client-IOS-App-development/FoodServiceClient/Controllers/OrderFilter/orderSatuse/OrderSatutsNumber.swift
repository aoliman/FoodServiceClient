//
//  OrderSatutsNumber.swift
//  FoodServiceClient
//
//  Created by Index on 6/3/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit

class OrderSatutsNumber: UITableViewCell {

    @IBOutlet weak var OrderNumberlabel: UILabel!
    @IBOutlet weak var OrderNumberValue: UILabel!
    @IBOutlet weak var OrderStatuslabel: UILabel!
    @IBOutlet weak var OrderStatusValue: UILabel!
    
    @IBOutlet weak var OrderDetaileslabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        OrderNumberlabel.text = "Order Number : ".localize()
        OrderStatuslabel.text = "Order Status : ".localize()
        OrderDetaileslabel.text = "Order Details : ".localize()
    }

   

}
