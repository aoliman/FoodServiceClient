//
//  Quantity.swift
//  FoodService
//
//  Created by index-ios on 3/25/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Material
class QuantityCell: UITableViewCell , TextFieldDelegate{

    @IBOutlet weak var PriceLable: UILabel!
    @IBOutlet weak var QuantityEditTxt: ErrorTextField!
    @IBOutlet weak var NameLable: UILabel!
    @IBOutlet weak var DeleteBtn: UIButton!
    var max :Int!
    var min :Int!
    override func awakeFromNib() {
        super.awakeFromNib()
       NameLable.text="name".localized()
       PriceLable.text="price".localized()
        
        
        
        QuantityEditTxt.placeholderActiveColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        QuantityEditTxt.placeholderNormalColor=#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        QuantityEditTxt.dividerColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5591430664)
        QuantityEditTxt.dividerActiveColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        QuantityEditTxt.dividerNormalColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        QuantityEditTxt.placeholderLabel.textAlignment = .center
        QuantityEditTxt.dividerNormalHeight=2
        QuantityEditTxt.dividerActiveHeight=3
        QuantityEditTxt.textAlignment = .center
        QuantityEditTxt.layer.cornerRadius=10
        if #available(iOS 10.0, *) {
            QuantityEditTxt.keyboardType = .asciiCapableNumberPad
        } else {
            // Fallback on earlier versions
        }
  
    }

  
    @IBAction func Quantitydidchange(_ sender: ErrorTextField) {

//        }
       
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        
        if let text = textField.text {
            
            let newStr = (text as NSString)
                .replacingCharacters(in: range, with: string)
            if newStr.isEmpty {
                return true
            }
            if   let intvalue = Int(newStr){
                return (intvalue >= 0 && intvalue <= 3)

            }
        }
        
        return true
    }
    
}
