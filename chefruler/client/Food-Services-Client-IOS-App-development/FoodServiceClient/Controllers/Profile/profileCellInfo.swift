//
//  profileCellInfo.swift
//  FoodService
//
//  Created by index-ios on 4/1/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Material
import Cosmos
class profileCellInfo: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
  //  @IBOutlet weak var email: UILabel!
    
   // @IBOutlet weak var phonenumber: UILabel!
    
    @IBOutlet weak var Typedelivery: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var countary: UILabel!
    @IBOutlet weak var imagrprofile: UIImageView!
    @IBOutlet weak var Btnconnect: RaisedButton!
    @IBOutlet weak var btntopconstrain: NSLayoutConstraint!
    @IBOutlet weak var imagebottomconstrain: NSLayoutConstraint!
    @IBOutlet weak var btnhightconstrain: NSLayoutConstraint!
    @IBOutlet weak var ImageHightconstrain: NSLayoutConstraint!
    
    @IBOutlet weak var RateView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        LocationLabel.text="Location Of Workplace".localized()
        Btnconnect.setTitle("Connect".localized(), for: .normal)
        
        
        imagebottomconstrain.constant=(UIScreen.main.bounds.height*5/100)/3
        btnhightconstrain.constant=(UIScreen.main.bounds.height*5/100)/3
        ImageHightconstrain.constant=(UIScreen.main.bounds.height*5/100)/3
        btntopconstrain.constant=(UIScreen.main.bounds.height*5/100)/3
        imagrprofile.layer.cornerRadius=imagrprofile.frame.height/2
        Btnconnect.layer.cornerRadius=6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        imagrprofile.layer.cornerRadius=imagrprofile.frame.height/2
        Btnconnect.layer.cornerRadius=6
    }

}
