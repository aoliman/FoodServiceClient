//
//  DeliveryGuyPresentInfo.swift
//  FoodServiceClient
//
//  Created by Index on 7/4/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit

class DeliveryGuyPresentInfo: UIViewController {

    
    @IBOutlet weak var ordernumberlabe: UILabel!
    @IBOutlet weak var ordernumbervalue: UILabel!
    @IBOutlet weak var distancelabel: UILabel!
    @IBOutlet weak var destancevalue: UILabel!
    @IBOutlet weak var deliverynamelabel: UILabel!
    @IBOutlet weak var deliverynamevalue: UILabel!
    @IBOutlet weak var deliveryphonelabel: UILabel!
    @IBOutlet weak var deliveryphonevalue: UILabel!
    @IBOutlet weak var totalpricelabel: UILabel!
    @IBOutlet weak var totalpricevalue: UILabel!
    
    var orderItem:OrderData!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
        
        ordernumberlabe.text = "Order Number".localize()
        distancelabel.text = "Distance".localize()
        deliverynamelabel.text = "Delivery Guy name".localize()
        deliveryphonelabel.text = "Delivery Guy Phone".localize()
        totalpricelabel.text = "Total Price".localize()
       
        
        ordernumbervalue.text = "\(orderItem.id!)"
        destancevalue.text = " \(orderItem.km!) \("km".localize()) "
        deliverynamevalue.text = orderItem.deliveryGuy.name!
        deliveryphonevalue.text = orderItem.deliveryGuy.phone!
        totalpricevalue.text = " \(orderItem.price!) \("Riyal".localize())"
        
        
        
    }

  

}
