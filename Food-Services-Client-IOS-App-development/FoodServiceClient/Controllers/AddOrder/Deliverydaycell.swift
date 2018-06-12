//
//  Deliverydaycell.swift
//  FoodService
//
//  Created by index-ios on 3/25/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Material
import  Localize_Swift
class Deliverydaycell: UITableViewCell {

    @IBOutlet weak var dattxt: ErrorTextField!
    
    @IBOutlet weak var determinelabel: UILabel!
    @IBOutlet weak var timetxt: ErrorTextField!
    @IBOutlet weak var clanderbtn: UIButton!
    @IBOutlet weak var timebtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       determinelabel.text="The day on which the application is to be delivered".localized()
       dattxt.text="Determinde Delivary Day".localized()
       timetxt.text = "Determinde Delivary Time".localized()
        setup(dattxt: dattxt)
        setup(dattxt: timetxt)
        
    }

 
    @IBAction func Determindedayinsidein(_ sender: Any) {
        
    }
    func setup(dattxt:ErrorTextField){
        dattxt.placeholderActiveColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        dattxt.placeholderNormalColor=#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        dattxt.dividerColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5591430664)
        dattxt.dividerActiveColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        dattxt.dividerNormalColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        dattxt.placeholderLabel.textAlignment = .center
        dattxt.dividerNormalHeight=2
        dattxt.dividerActiveHeight=3
        dattxt.layer.cornerRadius=10
        
        if Localize.currentLanguage() == "en" {
            dattxt.semanticContentAttribute = .forceLeftToRight
            dattxt.textAlignment = .left
            
            
        }else{
            dattxt.semanticContentAttribute = .forceRightToLeft
            dattxt.textAlignment = .right
            
        }
    }
}
