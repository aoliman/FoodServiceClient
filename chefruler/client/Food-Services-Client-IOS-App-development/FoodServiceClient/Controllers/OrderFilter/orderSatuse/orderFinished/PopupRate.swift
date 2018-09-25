//
//  PopupRate.swift
//  FoodServiceClient
//
//  Created by index-ios on 5/15/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Toast_Swift
import Cosmos
protocol RateSend {
    
    func SendRate()
}



class PopupRate: UIViewController {

    
    @IBOutlet weak var Orderlabel: UILabel!
    @IBOutlet weak var Deliverylabel: UILabel!
    @IBOutlet weak var BtnOk: UIButton!
    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var BtnCancel: UIButton!
    @IBOutlet weak var ok: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    
    
    @IBOutlet weak var rate0: UIButton!
    @IBOutlet weak var rate1: UIButton!
    @IBOutlet weak var rate2: UIButton!
    @IBOutlet weak var rate3: UIButton!
    @IBOutlet weak var rate4: UIButton!
    
    
    
    
    
    
    
    
    @IBOutlet weak var DeliveryRateView: CosmosView!
    var orderratevalue = 0
    var deliveryratevalue = 0
    var OrderId :Int!
    var OrderOwner :Int!
    var isDeliveryguyorder :Bool!
    var getallproducte = GetallProdacteRepo()
    var clientid:Int!
    
    var delegate:RateSend!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DeliveryRateView.settings.starSize = Double(DeliveryRateView.layer.frame.width/3)
        DeliveryRateView.settings.starMargin = DeliveryRateView.settings.starSize/9
        rate0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        rate1.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        rate2.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        rate3.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        rate4.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
    }

   
    @IBAction func OrderAction(_ sender: UIButton) {
       
        orderratevalue = sender.tag
        rate0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        rate1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        rate2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        rate3.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        rate4.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       
    }
    
//    @IBAction func DeliveryAction(_ sender: UIButton) {
//        deliveryratevalue = sender.tag
//        //sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//    }
    
    
    @IBAction func OkAction(_ sender: Any) {
        if(isDeliveryguyorder){
            if (DeliveryRateView.rating != -1 && orderratevalue != 0 ){
                print(OrderId)
                
                myLoader.showCustomLoaderview(uiview: self.view)
                getallproducte.SendOrderRate(orderid: OrderId , rate: Int(DeliveryRateView.rating), clientid: clientid, completionSuccess: { (response) in
                    print(response)
                    
                    self.getallproducte.SendOrderRate(orderid: self.OrderOwner , rate: self.orderratevalue, clientid: self.clientid, completionSuccess: { (response) in
                        print(response)
                        self.dismiss(animated: false, completion: nil)
                        
                        self.delegate.SendRate()
                        myLoader.hideCustomLoader()
                    })
                    
                    
                })
               
            }else if(orderratevalue == 0){
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Choose Order Rate".localize())
                
            }else if(DeliveryRateView.rating == -1){
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Choose Delivery Rate".localize())
                
            }
        }else{
            if ( orderratevalue != 0 ){
                print(OrderId)
                myLoader.showCustomLoaderview(uiview: self.view)
                getallproducte.SendOrderRate(orderid: OrderId , rate: orderratevalue, clientid: clientid, completionSuccess: { (response) in
                    print(response)
                    self.dismiss(animated: false, completion: nil)
                    self.delegate.SendRate()
                    myLoader.hideCustomLoader()
                    self.dismiss(animated: true, completion: nil)
                })
//                getallproducte.SendOrderRate(orderid: OrderOwner , rate: Float(orderratevalue), completionSuccess: { (response) in
//                    print(response)
              //  })
            }else if(orderratevalue == 0){
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Choose Order Rate".localize())
                
            }
        }
      
    }
    
    
    @IBAction func CancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func setup(){
       //view
        
        
        
        
        PopupView.layer.cornerRadius = 16
        PopupView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        PopupView.layer.shadowOpacity = 1
        PopupView.layer.shadowOffset = CGSize(width: 20, height: 20)
        PopupView.layer.shadowRadius = 5
        PopupView.layer.shadowPath = UIBezierPath(rect: PopupView.bounds).cgPath
        PopupView.layer.shouldRasterize = true
        PopupView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        
        //add shadow for view
       var  shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: PopupView.bounds, cornerRadius: 10).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 2
        
        PopupView.layer.insertSublayer(shadowLayer, at: 0)
        
        //label
        Orderlabel.text = "Order Rate".localize()
        Deliverylabel.text = "Delivery Rate".localize()
        //button
        ok.layer.cornerRadius = 8
        cancel.layer.cornerRadius = 8
        ok.setTitle("OK".localize(), for: .normal)
        cancel.setTitle("Cancel".localize(), for: .normal)
        if(isDeliveryguyorder){
           DeliveryRateView.settings.fillMode = .precise
            
           
        }else{
          Deliverylabel.isHidden = true
         
        }
    }
    
    
    
    
   

}
