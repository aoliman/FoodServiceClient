//
//  DetailesProductInfoCell.swift
//  FoodServiceClient
//
//  Created by Index on 5/29/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Cosmos
class DetailesProductInfoCell: UITableViewCell {

    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var Pricevalue: UILabel!
    @IBOutlet weak var Ingreatiantslabel: UILabel!
    @IBOutlet weak var ingrediantsvalue: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var RateValue: CosmosView!
    @IBOutlet weak var PreprationLabel: UILabel!
    @IBOutlet weak var PreprationValue: UILabel!
    @IBOutlet weak var reservationlabel: UILabel!
    @IBOutlet weak var reservationValue: UILabel!
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PriceLabel.text = "Price".localize()
        Pricevalue.text="Lable".localized()
        
        Ingreatiantslabel.text = "Ingredients".localize()
        ingrediantsvalue.text="Lable".localized()
        
        rateLabel.text = "Rate".localize()
        
        
        PreprationLabel.text="Preparation Duration".localized()
        reservationlabel.text="Reservation Time".localized()
        PreprationValue.text="Lable".localized()
        reservationValue.text="Lable".localized()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 20
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 20
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
    }

   

}
