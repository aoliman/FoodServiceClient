//
//  WaydeliveryCell.swift
//  FoodService
//
//  Created by index-ios on 3/25/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import BEMCheckBox
class WaydeliveryCell: UITableViewCell , BEMCheckBoxDelegate {

    
    @IBOutlet weak var selectmethod: UILabel!
    
    @IBOutlet weak var deliveryguy: UILabel!
    @IBOutlet weak var Persondelivery: UILabel!
    @IBOutlet weak var checkbox2: BEMCheckBox!
    @IBOutlet weak var ceckbox1: BEMCheckBox!
    override func awakeFromNib() {
        super.awakeFromNib()
        deliveryguy.text="Delivery guy".localized()
        Persondelivery.text="Personal delivery".localized()
        selectmethod.text="Select the delivery method".localized()
        
        
        ceckbox1.delegate=self
        checkbox2.delegate=self
        var  group = BEMCheckBoxGroup(checkBoxes: [ceckbox1, checkbox2])
        
        // Optionally set which checkbox is pre-selected
        checkbox2.onAnimationType = .fill
        ceckbox1.onAnimationType = .fill
        checkbox2.offAnimationType = .fill
        ceckbox1.offAnimationType = .fill
        ceckbox1.onCheckColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ceckbox1.onFillColor=#colorLiteral(red: 0.3409686387, green: 0.721593976, blue: 0.8196011186, alpha: 1)
        ceckbox1.onTintColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        checkbox2.onCheckColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        checkbox2.onFillColor=#colorLiteral(red: 0.3409686387, green: 0.721593976, blue: 0.8196011186, alpha: 1)
        checkbox2.onTintColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        checkbox2.minimumTouchSize=CGSize(width: 20, height: 20)
        group.selectedCheckBox = self.ceckbox1
        
    }
   
    func didTap(_ checkBox: BEMCheckBox) {
      
        if (checkBox.tag == 0) {

            Editclientdeliverytype(type :"DIRECT")

        }else if (checkBox.tag == 1) {
            Editclientdeliverytype(type :"DELIVERY_GUY")

        }
    }
    
    func Editclientdeliverytype(type :String){
        var card = retetrivecard()
        UserDefaults.standard.removeSuite(named: Card)
        card.clientDeliveryType = type
        
        var addcarddata = [String : Any ]()
        var  dictionarydata:[[String:Any]]=[]
        for dic in card.productOrders {
            dictionarydata.append(dic.toDictionary())
        }
        
        
        
        
        addcarddata=["ownedid" : card.ownedid ,
                     "client": card.client ,
                     "deliveryDate" : card.deliveryDate ,
                     "clientDeliveryType": card.clientDeliveryType ,
                     "cookerDeliveryType": card.cookerDeliveryType,
                     "deliveryPlace":card.deliveryPlace,
                     "productOrders" : dictionarydata]
        let carddata=Cardorder.init(fromDictionary: addcarddata)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: carddata)
        UserDefaults.standard.set(encodedData, forKey: Card)
        UserDefaults.standard.synchronize()
        print(retetrivecard().toDictionary())
    }

   

}
