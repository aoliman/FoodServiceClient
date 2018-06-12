//
//  LoginService.swift
//  FoodService
//
//  Created by index-ios on 3/11/18.
//  Copyright © 2018 index-ios. All rights reserved.
//
import UIKit
import Moya
import GoogleMaps
import GooglePlaces
enum ProductService{
   case SignUp(name :String,email :String,password :String,phone :String,address :String)
    case GetProducte(page :Int ,limit :Int ,status :String,lat :Double ,long :Double ,raduis :Int)
    case  GetHomeCookerPlace(ownedid : Int ,type:String)
    case GetSpecificHomeCookerProduct(page :Int ,limit :Int ,userId :Int ,type:String)
     case GetProfileInfo(Id :Int ,Type :String )
    case GetSpecificProduct(Id :Int)
    case CreateOrder(Card : Cardorder , type:String)
    case GetPartyCookerCatogary(page :Int ,limit :Int )
    case CreateOrderPartyCooker(PartyCookerid:Int,lang :Double , lat:Double,Date:Int,Count:Int ,productOrders:[[String:Int]])
    case GetAllFoodCar(page :Int ,limit :Int)
    case GetCreditCardInfo(Id :Int)
    case GetFoodCarForMap(lat :Double , long :Double , radius:Int)
    case SendLanguage(Language : String)
    case GetDeliveryGuy(page :Int ,limit :Int ,lat :Double ,long :Double ,raduis :Int)
    case SendOrderRate(Orderid :Int, Rate :Int ,clientid :Int)
    case GetDeliveryGuyInfo(Id :Int)
    case SendOrderStatus(Orderid :Int,clientid :Int, Status :String  ,type :String)
    case SendOrderDeliveryGuy(DeliveryId:Int , cookerlocation: CLLocationCoordinate2D ,deliverylocation:CLLocationCoordinate2D , Orderlaction:CLLocationCoordinate2D ,orderid:Int)
    case GetOrderPriceDeliveryGuy(DeliveryId:Int , cookerlocation: CLLocationCoordinate2D ,deliverylocation:CLLocationCoordinate2D , Orderlaction:CLLocationCoordinate2D , orderid:Int)
    case GetCatTegory(page :Int ,limit :Int ,type :String,lat :Double ,long :Double ,raduis :Int)
    
}
extension ProductService :TargetType  {
    
    
   
    var sampleData: Data {
        return Data()
    }
    
   var baseURL: URL {
       return URL(string: "http://165.227.96.25/api/v1")!
    }
    
    var path: String {
        switch self {
        case .SignUp:
            return "/signup"
        case .GetProducte :
          return  "/products"
         //?page=\(page)&limit=\(limit)&status=\(status)
        case .GetHomeCookerPlace(let ownedid ,let type) :
            return "/\(type)/\(ownedid)/delivery-places"
        case .GetSpecificHomeCookerProduct(let page,let  limit,let userId , let type ):
           return "/\(type)/\(userId)/products"
        case .GetProfileInfo(let Id,let  Type) :
        return "/\(Type)/\(Id)"
        case .GetSpecificProduct(let Id) :
         return  "/products/\(Id)"
        case .CreateOrder(let Card,let type) :
            return "/\(type)/\(Card.client!)/orders"
        case .GetPartyCookerCatogary(let page,let  limit) :
          return  "/party-cookers"
        case .CreateOrderPartyCooker(let PartyCookerid,let lang ,let lat,let Date , let Count ,let productOrders) :
            return"/party-cookers/\(PartyCookerid)/orders"
        case.GetAllFoodCar(let page,let  limit):
            return "/food-cars"
        case .GetCreditCardInfo(let Id ) :
            return "/clients/\(Id)/credit-card"
        case .GetFoodCarForMap:
            return "/food-cars/near"
        case .SendLanguage:
             return "/language"
        case .GetDeliveryGuy :
            return"/delivery-guys/near"
        case .GetDeliveryGuyInfo(let Id) :
            return "/delivery-guys/\(Id)"
        case .SendOrderRate(let Orderid,let  Rate ,let clientid ) :
            return "/clients/\(clientid)/orders/\(Orderid)/rate"
        case .SendOrderStatus(let Orderid,let clientid,let Status,let type) :
            return "/\(type)/\(clientid)/orders/\(Orderid)/status"
        case .SendOrderDeliveryGuy(let DeliveryId , let cookerlocation,let  deliverylocation ,let Orderlaction,let orderid):
            return "/delivery-guys/\(DeliveryId)/orders"
        case .GetOrderPriceDeliveryGuy(let DeliveryId , let cookerlocation,let  deliverylocation ,let Orderlaction,let orderid):
            return "/delivery-guys/\(DeliveryId)/orders/price"
            
        case .GetCatTegory(let page,let limit,let  type,let lat,let long,let raduis):
            return "/\(type)/near"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .SignUp , .CreateOrder , .CreateOrderPartyCooker ,.SendOrderDeliveryGuy:
            return .post
        case .GetProducte,.GetCatTegory:
            return .get
    case .GetHomeCookerPlace ,.GetSpecificHomeCookerProduct ,.GetProfileInfo , .GetSpecificProduct ,.GetPartyCookerCatogary , .GetAllFoodCar , .GetCreditCardInfo ,.GetFoodCarForMap ,.GetDeliveryGuy ,.GetDeliveryGuyInfo ,.GetOrderPriceDeliveryGuy:
            return .get
        case .SendLanguage , .SendOrderRate ,.SendOrderStatus:
            return .put
        }
    }
    
  
   public   var task: Task {
    switch self {
    case .SignUp , .GetSpecificHomeCookerProduct  , .SendLanguage ,.SendOrderRate , .SendOrderStatus :
        return.requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
   
    case  .GetHomeCookerPlace , .GetProfileInfo , .GetSpecificProduct , .GetCreditCardInfo ,.GetDeliveryGuyInfo :
        return .requestPlain
    case .GetProducte  ,.GetPartyCookerCatogary ,.GetAllFoodCar ,. GetFoodCarForMap , .GetDeliveryGuy,.GetCatTegory:
        return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
    case .CreateOrder , .CreateOrderPartyCooker ,.GetOrderPriceDeliveryGuy ,.SendOrderDeliveryGuy :
      return.requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
        
    }
    
    }
    
    
   
   
    
    
    
    public  var headers: [String : String]? {
        switch self {
        case .SignUp:
       return ["Content-type": "application/json"]
        case .GetProducte , .GetHomeCookerPlace , .GetSpecificHomeCookerProduct , .GetProfileInfo , .GetSpecificProduct , .GetPartyCookerCatogary , .CreateOrderPartyCooker ,.GetAllFoodCar , .GetCreditCardInfo , .GetFoodCarForMap , .GetDeliveryGuy , .GetDeliveryGuyInfo,.GetOrderPriceDeliveryGuy ,.SendOrderDeliveryGuy:
            return   ["Content-Type": "application/json" , "Authorization" : "Bearer \(getUserAuthKey())"]
            case .CreateOrder , .SendLanguage ,.SendOrderRate ,.SendOrderStatus ,.GetCatTegory:
                return  ["Content-Type": "application/json" , "Authorization" : "Bearer \(getUserAuthKey())"]
        
        }
    }
    
    
    public  var parameters: [String: Any]? {
        
        switch self {
       case .SignUp(let name,let email,let password,let phone,let address):
        return ["name": name,"email": email,"password": password,"phone": phone,"address": address, "type": "CLIENT"]
            
        case .GetProducte(let page,let limit,let status  , let lat  ,let long  ,let raduis ):
        
         return["page":page,"limit":limit,"status":status ,"long": long,"lat":lat ,"radius": raduis]
        case .GetHomeCookerPlace(let ownedid ,let type):
            return nil
        case .GetSpecificHomeCookerProduct(let page,let limit,let userId, let type ) :
            return ["page":page,"limit":limit]
        case .GetProfileInfo , .GetSpecificProduct , .GetCreditCardInfo ,.GetDeliveryGuyInfo:
            return nil
        case .CreateOrder(let Card, let type):
            
            if(Card.cookerDeliveryType == "COOKER_PLACE"){
                return [
                    "client": Card.client ,
                    "deliveryDate" : Card.deliveryDate ,
                    "clientDeliveryType": Card.clientDeliveryType ,
                    "cookerDeliveryType": Card.cookerDeliveryType,
                    
                    "productOrders":Card.toDictionary()["productOrders"]]
            
            }else{
                return [
                    "client": Card.client ,
                    "deliveryDate" : Card.deliveryDate ,
                    "clientDeliveryType": Card.clientDeliveryType ,
                    "cookerDeliveryType": Card.cookerDeliveryType,
                    "deliveryPlace": Card.deliveryPlace,
                    "productOrders":Card.toDictionary()["productOrders"]]
            }
            
        case .GetPartyCookerCatogary(let page,let limit):
            
            return["page":page,"limit":limit]
        case .CreateOrderPartyCooker(let PartyCookerid,let lang ,let lat,let Date , let Count ,let productOrders):
            return ["client":getUserId(),
                    "cookingLocationLng": lang,
                    "cookingLocationLat": lat,
                    "appointmentDate": Date,
                    "individualsCount": Count,
                    "productOrders":productOrders
            ]
        case.GetAllFoodCar(let page,let  limit):
            return ["page":page,"limit":limit]
        case .GetFoodCarForMap(let lat,let long,let radius):
            return ["long": long,"lat":lat ,"radius": 10,"page":1,"limit":100]
            
            
        case .SendLanguage(let Language) :
            return ["language": Language]
        case .GetDeliveryGuy(let page,let limit , let lat  ,let long  ,let raduis ):
           return  ["long": long,"lat":lat ,"radius": 10]
        case .SendOrderRate(let Orderid, let Rate ,let  clientid) :
            return ["rate": Rate]
        case .SendOrderStatus(let Orderid,let clientid,let Status,let type) :
            return ["status":Status]
        case .SendOrderDeliveryGuy(let DeliveryId , let cookerlocation,let  deliverylocation ,let Orderlaction,let orderid):
            return ["fromLocationLng": cookerlocation.longitude,
                    "fromLocationLat": cookerlocation.latitude,
                    "toLocationLng": Orderlaction.longitude,
                    "toLocationLat": Orderlaction.latitude,
                    "currentDeliveryGuyLocationLng": deliverylocation.longitude,
                    "currentDeliveryGuyLocationLat": deliverylocation.latitude,
                    "order": orderid]
        case .GetOrderPriceDeliveryGuy(let DeliveryId , let cookerlocation,let  deliverylocation ,let Orderlaction,let orderid):
            return ["fromLocationLng": cookerlocation.longitude,
                    "fromLocationLat": cookerlocation.latitude,
                    "toLocationLng": Orderlaction.longitude,
                    "toLocationLat": Orderlaction.latitude,
                    "currentDeliveryGuyLocationLng": deliverylocation.longitude,
                    "currentDeliveryGuyLocationLat": deliverylocation.latitude,
                    "orderId": orderid]
            
        case .GetCatTegory(let page,let limit,let  type,let lat,let long,let raduis):
            return["page":page,"limit":limit ,"long": long,"lat":lat ,"radius": raduis]
        
        }
     
        
        
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .SignUp , .CreateOrder , .CreateOrderPartyCooker ,.SendLanguage ,.SendOrderRate ,.SendOrderStatus  , .SendOrderDeliveryGuy:
            return   JSONEncoding.default
        case .GetProducte , .GetHomeCookerPlace , .GetSpecificHomeCookerProduct , .GetProfileInfo ,.GetSpecificProduct ,.GetPartyCookerCatogary , .GetAllFoodCar , .GetCreditCardInfo , .GetFoodCarForMap  ,.GetDeliveryGuyInfo, .GetDeliveryGuy , .GetOrderPriceDeliveryGuy ,.GetCatTegory:
            return URLEncoding.default
        }
    }
    
   
}

