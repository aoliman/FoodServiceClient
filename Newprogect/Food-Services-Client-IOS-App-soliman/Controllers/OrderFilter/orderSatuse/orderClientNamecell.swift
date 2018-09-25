//
//  orderClientNamecell.swift
//  FoodServiceClient
//
//  Created by Index on 6/3/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit

class orderClientNamecell: UITableViewCell {

    
 
    @IBOutlet weak var ClientNamelabel: UILabel!
    @IBOutlet weak var AdressValue: UILabel!
    @IBOutlet weak var ClientNameValue: UILabel!
    @IBOutlet weak var Numberofcusteslable: UILabel!
    @IBOutlet weak var NumberofcustesValue: UILabel!
    @IBOutlet weak var TotalChargeLabel: UILabel!
    @IBOutlet weak var TotalChargeValue: UILabel!
    @IBOutlet weak var AdressLabel: UILabel!
    
    
    @IBOutlet weak var DeliveredBtn: UIButton!
    @IBOutlet weak var GetDiraction: UIButton!
    @IBOutlet weak var GetdeliveryGuy: UIButton!
    @IBOutlet weak var ViewBtnHieight: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        ClientNamelabel.text = "Client Name".localize()
        AdressLabel.text = "Address".localize()
        Numberofcusteslable.text = "Number of Guests".localize()
        TotalChargeLabel.text = "Total Charge".localize()
        
        AdressValue.text = "Lable".localize()
        ClientNameValue.text = "Lable".localize()
        TotalChargeValue.text = "Lable".localize()
        NumberofcustesValue.text = "Lable".localize()
        GetDiraction.setTitle("Get Directions".localize(), for: .normal)
        GetdeliveryGuy.setTitle("Get Delivery Guy".localize(), for: .normal)
        DeliveredBtn.setTitle("Delivered".localize(), for: .normal)
    
    
    
    
    
    }

   

}
