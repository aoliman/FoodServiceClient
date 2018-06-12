//
//  PopupDeliveryInfo.swift
//  FoodServiceClient
//
//  Created by Index on 5/17/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Cosmos
protocol DeliveryGuychoose :class{
    func PushDeliveryOrderDetailes(Orderdetailes:OrderData,deliveryguy:DeliveryGuyInfoRes)
}
class PopupDeliveryInfo: UIViewController {
//delegate
    weak var delegate:DeliveryGuychoose?
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var email: UILabel!
   
    @IBOutlet weak var Btnorder: UIButton!
    @IBOutlet weak var Popview: UIView!
    @IBOutlet var Parentview: UIView!
    @IBOutlet weak var RateView: CosmosView!
   // /4
    @IBOutlet weak var topImage: NSLayoutConstraint!
    @IBOutlet weak var Stacktop: NSLayoutConstraint!
    @IBOutlet weak var Btntop: NSLayoutConstraint!
    var Myname :String!
    var Myimage:String!
    var Myrate:Float!
    var myAdress:String!
    var deliveryguy:DeliveryGuyInfoRes!
    var  Orderdetailes:OrderData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              setup()
        
        
    }
    override func viewDidLayoutSubviews() {
       Image.layer.cornerRadius = Image.frame.height/2
        Image.clipsToBounds = true
    }
   
    
    
    @IBAction func BtnOrderAction(_ sender: Any) {
      
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let passController : DeliveryOrderDetailes = storyboard.instantiateViewController(withIdentifier: "DeliveryOrderDetailes") as! DeliveryOrderDetailes
//
//        present(passController, animated: true, completion: nil)
        delegate?.PushDeliveryOrderDetailes(Orderdetailes: Orderdetailes, deliveryguy: deliveryguy)
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    
    
    
   func setup(){
    Btnorder.layer.cornerRadius = 10
    Btnorder.setTitle("Order Detailes".localize(), for: .normal)
    
    
    
    topImage.constant = Popview.layer.frame.height*1/40+3
    Stacktop.constant = Popview.layer.frame.height*1/40
    Btntop.constant = Popview.layer.frame.height*1/40
    Popview.layer.cornerRadius  = 10
    
//    var  shadowLayer = CAShapeLayer()
//    shadowLayer.path = UIBezierPath(roundedRect: Popview.frame, cornerRadius: 10).cgPath
//    shadowLayer.fillColor = UIColor.white.cgColor
//
//    shadowLayer.shadowColor = UIColor.darkGray.cgColor
//    shadowLayer.shadowPath = shadowLayer.path
//    shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//    shadowLayer.shadowOpacity = 0.5
//    shadowLayer.shadowRadius = 2
//    Popview.layer.insertSublayer(shadowLayer, at: 0)
    
    Parentview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
    
    
    Name.text = Myname
    RateView.rating = Double(Myrate)
    Image.af_setImage(withURL: URL(string: Myimage)! )
    email.text = myAdress
     Image.layer.cornerRadius = Image.frame.height/2
     Image.clipsToBounds = true
    RateView.settings.updateOnTouch = false
    // Show only fully filled stars
    RateView.settings.fillMode = .precise
    RateView.text=String(Myrate)
    
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }

    
    
    

  
}
