//
//  PaymentmenuCell.swift
//  FoodServiceClient
//
//  Created by Index on 6/24/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import LTHRadioButton
class PaymentmenuCell: UITableViewCell {
    @IBOutlet weak var ViewRadioButton: UIView!
    @IBOutlet weak var PaymentImage: UIImageView!
    @IBOutlet weak var Paymentnumber: UILabel!
    
    
    @IBOutlet weak var BorderView: UIView!
    var  RadioButton = LTHRadioButton(selectedColor: #colorLiteral(red: 0.01883193478, green: 0.6361140609, blue: 0.7167189121, alpha: 1))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RadioButton.deselect()
        Paymentnumber.adjustsFontSizeToFitWidth = true
        RadioButton.deselectedColor = #colorLiteral(red: 0.01883193478, green: 0.6361140609, blue: 0.7167189121, alpha: 1)
        ViewRadioButton.addSubview(RadioButton)
        PaymentImage.image = nil
        
//        RadioButton.onSelect {
//            //            print(self.myPayments[indexPath.row].id)
//            //            self.SetdefultePayment(paymentid:self.myPayments[indexPath.row].id, index:indexPath.row)
//            print("2")
//        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        RadioButton.deselect()
        Paymentnumber.adjustsFontSizeToFitWidth = true
        RadioButton.deselectedColor = #colorLiteral(red: 0.01883193478, green: 0.6361140609, blue: 0.7167189121, alpha: 1)
        ViewRadioButton.addSubview(RadioButton)
        PaymentImage.image = nil
    }
    

}
