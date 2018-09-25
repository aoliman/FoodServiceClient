//
//  BtnCell.swift
//  FoodService
//
//  Created by index-ios on 3/26/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Material
import Alamofire
import Moya_Gloss
class BtnCell: UITableViewCell {
    var Getallproducterepo = GetallProdacteRepo()
    @IBOutlet weak var btnordercomplition: RaisedButton!
    override func awakeFromNib() {
        super.awakeFromNib()
 btnordercomplition.setTitle("Order Confirmation".localized(), for: .normal)
        
    }
    override func layoutSubviews() {
        btnordercomplition.layer.cornerRadius=6
    }
  

    @IBAction func BtnCreatrOrder(_ sender: Any) {
        print(retetrivecard().toDictionary()["productOrders"])
       CreateOrderBtn(type:"home-cookers")
    }
    
func CreateOrderBtn(type:String){
//  let headers = ["Content-Type": "application/json","Authorization": "Bearer \(getUserAuthKey())"]
//    var parameters: [String : Any]!
//    var Card=retetrivecard()
//    if(Card.cookerDeliveryType == "COOKER_PLACE"){
//        parameters = [
//            "client": Card.client ,
//            "deliveryDate" : Card.deliveryDate ,
//            "clientDeliveryType": Card.clientDeliveryType ,
//            "cookerDeliveryType": Card.cookerDeliveryType,
//
//            "productOrders":Card.toDictionary()["productOrders"]]
//
//    }else{
//        parameters = [
//            "client": Card.client ,
//            "deliveryDate" : Card.deliveryDate ,
//            "clientDeliveryType": Card.clientDeliveryType ,
//            "cookerDeliveryType": Card.cookerDeliveryType,
//            "deliveryPlace": Card.deliveryPlace,
//            "productOrders":Card.toDictionary()["productOrders"]]
//    }
//
//     Alamofire.request("http://165.227.96.25/api/v1/\(type)/\(Card.client)/orders", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//            print("Request  \(response.request)")
//
//            print("RESPONSE \(response.result.value)")
//            print("RESPONSE \(response.result)")
//            print("RESPONSE \(response)")
//            switch response.result {
//            case .success: break
//            case .failure(let error): break
//            }
        }
//
  
    
    
    
    
    
}
