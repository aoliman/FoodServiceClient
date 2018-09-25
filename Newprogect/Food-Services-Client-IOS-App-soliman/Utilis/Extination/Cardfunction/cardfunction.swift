//
//  cardfunction.swift
//  FoodService
//
//  Created by index-ios on 3/28/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import Foundation

func savecard(ownerid:Int,clien:Int,deliveryDate:Int,cookerDeliveryType:String,clientDeliveryType:String,deliveryPlace:Int,count:Int,product:Int){
    // UserDefaults.standard.removeObject(forKey: Card)
    UserDefaults.standard.synchronize()
        var producteorderdata = CardProductOrder.init(fromDictionary: ["product":product  ,
                                                                   "count": count])
        var addcarddata = [String : Any ]()
         addcarddata=["ownedid" : ownerid ,
                         "client": clien ,
                         "deliveryDate" : deliveryDate ,
                         "clientDeliveryType": clientDeliveryType ,
                         "cookerDeliveryType": cookerDeliveryType,
                         "deliveryPlace":deliveryPlace,
                          "productOrders" : [producteorderdata.toDictionary()]]
          let carddata=Cardorder.init(fromDictionary: addcarddata)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: carddata)
        UserDefaults.standard.set(encodedData, forKey: Card)
   UserDefaults.standard.synchronize()
    
 
}

func retetrivecard() -> Cardorder {
    if  let data = UserDefaults.standard.data(forKey: Card){
     let mycard = NSKeyedUnarchiver.unarchiveObject(with: data)
        return (mycard as? Cardorder)!
        }else {
        var addcarddata = [String : Any ]()
        addcarddata=["ownedid" : 0 ,
                     "client": 0 ,
                     "deliveryDate" : 0 ,
                     "clientDeliveryType": "" ,
                     "cookerDeliveryType": "",
                     "deliveryPlace":0,
                     "productOrders" : [] ]
         let carddata=Cardorder.init(fromDictionary: addcarddata)
        return carddata
      
    }
    
}


func saveorderincard(product:Int,count: Int){
   var mycard = retetrivecard()
    var add=1
    
    var producteorderdata = CardProductOrder.init(fromDictionary: ["product":  product, "count": count ])
    
    var  dictionarydata:[[String:Any]]=[]
    for dic in mycard.productOrders {
        if(dic.product==producteorderdata.product){
            dic.count=producteorderdata.count
         dictionarydata.append(dic.toDictionary())
            add=0
        }else {
         dictionarydata.append(dic.toDictionary())
        }
    
    }
    if(add==1){
        
       dictionarydata.append(producteorderdata.toDictionary())
    }
    var addcarddata = [String : Any ]()
    addcarddata=["ownedid" : mycard.ownedid ,
                 "client": mycard.client ,
                 "deliveryDate" : mycard.deliveryDate ,
                 "clientDeliveryType": mycard.clientDeliveryType ,
                 "cookerDeliveryType": mycard.cookerDeliveryType,
                 "deliveryPlace": mycard.deliveryPlace,
                 "productOrders":dictionarydata]
    let carddata=Cardorder.init(fromDictionary: addcarddata)
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: carddata)
    UserDefaults.standard.set(encodedData, forKey: Card)
    UserDefaults.standard.synchronize()
}


func DeletProductfromcard(product:Int){
    var mycard = retetrivecard()
    var addcarddata = [String : Any ]()
    var  dictionarydata:[[String:Any]]=[]
    for dic in mycard.productOrders {
        if(dic.product==product){
           
        }else {
            dictionarydata.append(dic.toDictionary())
        }
        
    }
    if(dictionarydata.count==0){
        addcarddata=["ownedid" : 0 ,
                     "client": 0 ,
                     "deliveryDate" : 0 ,
                     "clientDeliveryType": "" ,
                     "cookerDeliveryType": "",
                     "deliveryPlace":0,
                     "productOrders" : [] ]
        
    }else{
        addcarddata=["ownedid" : mycard.ownedid ,
                     "client": mycard.client ,
                     "deliveryDate" : mycard.deliveryDate ,
                     "clientDeliveryType": mycard.clientDeliveryType ,
                     "cookerDeliveryType": mycard.cookerDeliveryType,
                     "deliveryPlace": mycard.deliveryPlace,
                     "productOrders":dictionarydata]
    }
   
    
    
    let carddata=Cardorder.init(fromDictionary: addcarddata)
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: carddata)
    UserDefaults.standard.set(encodedData, forKey: Card)
    UserDefaults.standard.synchronize()
}
func saveUserId(Userid:Int){
    UserDefaults.standard.set(Userid, forKey: UserId)
    UserDefaults.standard.synchronize()
}
func getUserId()->Int{
   return UserDefaults.standard.integer(forKey: UserId)
}

func saveUserAuthKey(Userauthkey:String){
    UserDefaults.standard.set(Userauthkey, forKey: UserAuthKey)
    UserDefaults.standard.synchronize()
}
func getUserAuthKey()->String{
    return UserDefaults.standard.string(forKey: UserAuthKey)!
}

//func getProductorder()->[[String:Any]] {
//
//}



