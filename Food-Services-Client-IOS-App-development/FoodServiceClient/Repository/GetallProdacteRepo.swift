//
//  GetProdacteRepo.swift
//  FoodService
//
//  Created by index-ios on 3/18/18.
//  Copyright © 2018 index-ios. All rights reserved.
//


import UIKit
import  Moya
import Moya_Gloss
import Toast_Swift
import GoogleMaps
import GooglePlaces
import RxSwift
import RxCocoa
class  GetallProdacteRepo  {
private var provider :MoyaProvider<ProductService>!
    var IsSend = BehaviorRelay<Bool>(value: false)
    init() {
        let endpointClosure = { (target: ProductService) -> Endpoint<ProductService> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields: ["Content-Type": "application/json","Authorization": "Bearer \(getUserAuthKey())"])
        }
        provider = MoyaProvider<ProductService>(endpointClosure: endpointClosure )

    }
    
    //get all producte function
    func GetAllProducte(page :Int ,limit :Int ,status :String,lat :Double , long :Double ,radius :Int ,completionSuccess: @escaping (Getallproductesuccess) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            print(" page :\(page) ,limit :\(limit) ,status :\(status)")
           // Loader.showLoader()
         //   myLoader.showCustomLoader()
            
            let cancellabel=provider.request(.GetProducte(page: page, limit: limit, status: status, lat: lat, long: long, raduis: radius )) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    print(response.data)
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(Getallproductesuccess.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    } else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    
                    print("staste code =\(responseError.response?.statusCode)")
                    print("error "+responseError.errorDescription!)
                    print("Here 1")
                    
                }
                
                //Load View Hide
                Loader.hideLoader()
            }
            
            cancellabelArry.append(cancellabel)
        } else {
            Loader.hideLoader()
            DataUtlis.data.noInternetDialog()
        }
       
        
        
    }
    
    
    
 // getallhomecookerplace
    func   GetHomeCookerPlace(ownedid : Int ,type:String, completionSuccess: @escaping ([HomeCookerPlacemodel]) -> () ){
        if DataUtlis.data.isInternetAvailable() {
           
            
            // myLoader.showCustomLoader()
            let cancellabel =  provider.request(.GetHomeCookerPlace(ownedid: ownedid , type:type)) { (result)  in
                switch result {
                    //Load View Show
                    
                case .success(let response):
                    
                    print("state  = \(response.statusCode)")
                    
                    if(response.statusCode == 201){
                        do {
                            let respnseapisucess = try response.mapArray(HomeCookerPlacemodel.self)
                            Loader.hideLoader()
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                   print("Here 2")
                    
                }
                
                
            }
            
            cancellabelArry.append(cancellabel)
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
   
        
        
    }
    
    //getproducte for Specific homecooker
    func GetSpecificHomeCookerProduct(page :Int ,limit :Int ,userId :Int , type:String ,completionSuccess: @escaping (Getallproductesuccess) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
            
            
            let cancellabel =  provider.request(.GetSpecificHomeCookerProduct(page: page, limit: limit, userId: userId, type: type)) { (result)  in
                switch result {
                    
                case .success(let response):
                    
                    
                    
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(Getallproductesuccess.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                  print("Here 3")
                    myLoader.hideCustomLoader()
                }
               
                
            }
             cancellabelArry.append(cancellabel)
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
       
       
        
        
    }
    
    
    
    //getprofileinfo
    func GetProfileInfo(id :Int ,type :String ,completionSuccess: @escaping (Owner) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            
            let cancellabel = provider.request(.GetProfileInfo(Id: id, Type: type)) { (result)  in
                switch result {
                    
                case .success(let response):
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(Owner.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                  print("Here 4")
                }
               
            }
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
   
        
        
        
    }
    
    //get one producte
    func GetSpecificProduct(id :Int  ,completionSuccess: @escaping (getproductdata) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
            
            
            let cancellabel = provider.request(.GetSpecificProduct(Id: id)) { (result)  in
                switch result {
                    
                case .success(let response):
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(getproductdata.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                  print("Here 5")
                }
            }
            Loader.hideLoader()
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
   
    
//create order frome home cooker
    func CreateOrder(Card : Cardorder , type:String,completionSuccess: @escaping (CreatOrderRes) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
            
            CancelAllrequsst()
           // myLoader.showCustomLoader()
            let cancellabel =  provider.request(.CreateOrder(Card: Card, type: type)) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    if(response.statusCode == 201){
                        do {
                            let respnseapisucess = try response.mapObject(CreatOrderRes.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                  print("Here 6")
                }
                //Load View Hide
                Loader.hideLoader()
                
            }
            
            cancellabelArry.append(cancellabel)
        } else {
            DataUtlis.data.noInternetDialog()
        }
      
    }
    
    
    //getproducte function
    func GetPartyCookerCatogary(page :Int ,limit :Int  ,completionSuccess: @escaping (PartyCookerCatogary) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            print(" page :\(page) ,limit :\(limit) ")
            //Load View Show
           
            CancelAllrequsst()
            let cancellabel=provider.request(.GetPartyCookerCatogary(page: page, limit: limit)  ) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    print(response.data)
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(PartyCookerCatogary.self)
                            print(respnseapisucess)
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                  print("Here 7")
                }
                //Load View Hide
                Loader.hideLoader()
            }
            
            cancellabelArry.append(cancellabel)
        } else {
            DataUtlis.data.noInternetDialog()
        }
      
        
        
    }
    
    
    
    
    
    ////create order for party cooker
    func CreateOrderfForPartyCooker(PartyCookerid:Int,lang :Double , lat:Double,Date:Int,Count:Int ,productOrders:[[String:Int]],completionSuccess: @escaping (PartyCookerResponse) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            
            CancelAllrequsst()
            //Load View Show
            
            let cancellabel =  provider.request(.CreateOrderPartyCooker(PartyCookerid: PartyCookerid, lang: lang, lat: lat, Date: Date, Count: Count, productOrders: productOrders)) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    if(response.statusCode == 201){
                        do {
                            let respnseapisucess = try response.mapObject(PartyCookerResponse.self)
                            
                            completionSuccess (respnseapisucess)
                            
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        do{try print(response.mapJSON())}catch{}
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print(responseError.response?.statusCode)
                    print("error "+responseError.errorDescription!)
                print("Here 8")
                }
                //Load View Hide
                Loader.hideLoader()
            }
            
            cancellabelArry.append(cancellabel)
        } else {
            DataUtlis.data.noInternetDialog()
        }
       
    }
    
    
    
    
    //get allfood car 
    func GetAllFoodCar(lat :Double ,long :Double , raduis :Int ,completionSuccess: @escaping (FoodCarCatogary) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
           
            
            let cancellabel=provider.request(.GetFoodCarForMap(lat: lat, long: long, radius: raduis)  ) { (result)  in
                switch result {
                    
                case .success(let response):
                  if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(FoodCarCatogary.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                  }else  {
                    Alert.showError(response)
                    myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print(responseError.response?.statusCode)
                    print("Here 9")
                }
                
               
            }
            
            cancellabelArry.append(cancellabel)
        } else {
            DataUtlis.data.noInternetDialog()
        }
     
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///cancel all request in moya
    func CancelAllrequsst(){
        cancellabelArry.forEach { cancellable in cancellable.cancel() }
        // here I go through the array and cancell each request.
        //Load View Hide
        cancellabelArry.removeAll()
    }
    
    
    
    //get client credit card info
    func GetCreditCardInfo(id :Int  ,completionSuccess: @escaping (CreditCard) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
            
            
            _ = provider.request(.GetCreditCardInfo(Id:id)) { (result)  in
                switch result {
                    
                case .success(let response):
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(CreditCard.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                    print("Here 10")
                }
            }
            Loader.hideLoader()
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
    //put language
    func SendLanguage(Language :String  ,completionSuccess: @escaping (CreditCard) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
            
          
            provider.request(.SendLanguage(Language: Language)) { (result)  in
                switch result {
                    
                case .success(let response):
                     print(response.statusCode)
                     do{
                        print(try response.mapJSON())
                     }
                     catch{
                        
                     }
                     
                    if(response.statusCode == 200){
                        do {
                           
                           let respnseapisucess = try response.mapObject(CreditCard.self)

                           completionSuccess (respnseapisucess)
                            print(respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                    print("Here 11")
                }
            }
            Loader.hideLoader()
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
   //get delivery guy
    func GetDeliveryGuy(page :Int ,limit :Int ,status :String,lat :Double , long :Double ,radius :Int ,completionSuccess: @escaping (DeliveryRes) -> ()){
        if DataUtlis.data.isInternetAvailable() {
           
           // Loader.showLoader()
          //  UIApplication.shared.keyWindow?.currentViewController()?.view.showBlurLoader()
           myLoader.showCustomLoader()
            let cancellabel=provider.request(.GetDeliveryGuy(page: page, limit: limit, lat: lat, long: long, raduis: radius )) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                   
                    do{
                        try  print(response.mapJSON())
                    }catch{}
                    if(response.statusCode == 200){
                        do {
                            
                            let respnseapisucess = try response.mapObject(DeliveryRes.self)
                            completionSuccess (respnseapisucess)
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("Here 12")
                    print("staste code =\(responseError.response?.statusCode)")
                    print("error "+responseError.errorDescription!)
                    
                }
                
                //Load View Hide
               // Loader.hideLoader()
               // UIApplication.shared.keyWindow?.currentViewController()?.view.removeBluerLoader()
               // myLoader.hideCustomLoader()
            }
            
            cancellabelArry.append(cancellabel)
        } else {
            Loader.hideLoader()
            DataUtlis.data.noInternetDialog()
        }
         }
    
    //get deleviry guy info
    func GetDeliveryguyInfo(id :Int ,completionSuccess: @escaping (DeliveryGuyInfoRes) -> ()){
        if DataUtlis.data.isInternetAvailable() {
           
         
           
            
            let cancellabel=provider.request(.GetDeliveryGuyInfo(Id: id)) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    print(response.data)
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(DeliveryGuyInfoRes.self)
                            
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    
                    print("staste code =\(responseError.response?.statusCode)")
                    print("error "+responseError.errorDescription!)
                    print("Here 13")
                }
                
                //Load View Hide
                Loader.hideLoader()
            }
            
            cancellabelArry.append(cancellabel)
        } else {
          //  Loader.hideLoader()
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
    //put order rate
    func SendOrderRate(orderid :Int, rate :Int , clientid:Int ,completionSuccess: @escaping (Any) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
           
           
            provider.request(.SendOrderRate(Orderid: orderid , Rate: rate, clientid: clientid)  ) { (result)  in
                switch result {
                    
                case .success(let response):
                  
                    
                    if(response.statusCode == 204){
                        do {
                            
                            let respnseapisucess = try response.mapJSON()
                            
                            completionSuccess (respnseapisucess)
                            print(respnseapisucess)
                            
                        }
                            
                        catch {
                            completionSuccess (result)
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    print("Here 14")
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                    
                }
            }
            Loader.hideLoader()
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
    
    //put OrderState
    func SendOrderStatus(Orderid :Int,clientid :Int, Status :String ,type :String ,completionSuccess: @escaping (Any) -> ()){
        if DataUtlis.data.isInternetAvailable() {
            //Load View Show
            
            
            provider.request(.SendOrderStatus(Orderid: Orderid, clientid: clientid, Status: Status, type: type)) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    do{
                        print(try response.mapJSON())
                    }
                    catch{
                        
                    }
                    
                    if(response.statusCode == 204){
                        do {
                            
//                            let respnseapisucess = try response.mapObject(CreditCard.self)
                            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Delivered".localize())
                           
                            completionSuccess (response.statusCode)
                           
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                        
                    
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                    print("Here 15")
                }
            }
            Loader.hideLoader()
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
    
    
    ///get price of delivery
    
    func GetOrderPriceDeliveryGuy(DeliveryId:Int , cookerlocation: CLLocationCoordinate2D ,deliverylocation:CLLocationCoordinate2D , Orderlaction:CLLocationCoordinate2D ,orderid:Int,completionSuccess: @escaping (DeliveryOrder) -> ()){
        if DataUtlis.data.isInternetAvailable() {
          
            
            provider.request(.GetOrderPriceDeliveryGuy(DeliveryId: DeliveryId, cookerlocation: cookerlocation, deliverylocation: deliverylocation, Orderlaction: Orderlaction, orderid: orderid)) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    do{
                        print(try response.mapJSON())
                    }
                    catch{
                        
                    }
                    
                    if(response.statusCode == 200){
                        do {
                            
                            let respnseapisucess = try response.mapObject(DeliveryOrder.self)
                            //UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Delivered".localize())
                            
                            completionSuccess (respnseapisucess)
                            
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                    print("Here 16")
                }
            }
           
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
    ///send order to delivery
    func SendOrderDeliveryGuy(DeliveryId:Int , cookerlocation: CLLocationCoordinate2D ,deliverylocation:CLLocationCoordinate2D , Orderlaction:CLLocationCoordinate2D ,orderid:Int,completionSuccess: @escaping (DeliveryOrder) -> ()){
        if DataUtlis.data.isInternetAvailable() {
          
            
            provider.request(.SendOrderDeliveryGuy(DeliveryId: DeliveryId, cookerlocation: cookerlocation, deliverylocation: deliverylocation, Orderlaction: Orderlaction, orderid: orderid)) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    do{
                        print(try response.mapJSON())
                    }
                    catch{
                        
                    }
                    
                    if(response.statusCode == 201){
                        do {
                            
                            let respnseapisucess = try response.mapObject(DeliveryOrder.self)
                            //UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Delivered".localize())
                            
                            completionSuccess (respnseapisucess)
                            
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        self.IsSend.accept(true)
//                        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Location ".localize())
                       Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                    
                    
                    
                case .failure(let responseError):
                    print("error "+responseError.errorDescription!)
                    print("Here 17")
                }
            }
           
            
            
        } else {
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
    
    //get all gatogary function
    func GetCatogary(page :Int ,limit :Int ,type :String,lat :Double , long :Double ,radius :Int ,completionSuccess: @escaping (Catogary) -> ()){
        
        if DataUtlis.data.isInternetAvailable() {
            print(" page :\(page) ,limit :\(limit) ,type :\(type)")
            // Loader.showLoader()
            //   myLoader.showCustomLoader()
            
            let cancellabel=provider.request(.GetCatTegory(page: page, limit: limit, type: type, lat: lat, long: long, raduis: radius)) { (result)  in
                switch result {
                    
                case .success(let response):
                    print(response.statusCode)
                    do{
                        print(try response.mapJSON())
                    }
                    catch{
                        
                    }
                    if(response.statusCode == 200){
                        do {
                            let respnseapisucess = try response.mapObject(Catogary.self)
                            print("resulte in repo \(respnseapisucess)")
                            completionSuccess (respnseapisucess)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                        }
                    }else  {
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                    }
                  case .failure(let responseError):
                    
                    print("staste code =\(responseError.response?.statusCode)")
                    print("error "+responseError.errorDescription!)
                    print("Here 18")
                }
                
                //Load View Hide
                Loader.hideLoader()
            }
            
            cancellabelArry.append(cancellabel)
        } else {
            Loader.hideLoader()
            DataUtlis.data.noInternetDialog()
        }
        
        
        
    }
    
    
    
    func submitCreditCard(token: String, completion: @escaping (User) -> ()) {
        
        
        let cancelLabel = provider.request(.creditCardInfo(id: (Singeleton.userInfo?.id)!, token: token)) {
            result in
            switch result {
            case .success(let response):
                do {
                    
                     print(response.statusCode)
                    do {
                        try print(response.mapJSON())
                    }
                    switch response.statusCode {
                    case StatusCode.complete.rawValue:
                        let response =  try response.mapObject(RegisterApi.self)
                        print(response)
                        completion(response.user)
                        myLoader.hideCustomLoader()
                        myLoader.hideCustomLoader()
                        
                    default:
                        let errorResponse =  try response.mapObject(APIError.self)
                        
                        var error = errorResponse.error
                        
                        error = (error != nil ) ? error : errorResponse.generalError![0].msg
                        

                        
                        
                            Alert.showError(response)
                            myLoader.hideCustomLoader()
                        //Alert.showAlert(title: "Error".localized(), message: error!)
//                        print(response.statusCode, "Undefined error")
                    }
                    
                } catch {
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "Something went wrong".localized())
                    myLoader.hideCustomLoader()
                }
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                myLoader.hideCustomLoader()
            }
        }
        
    }
    
    
    
    
    
    func AddPayment(Paymenttoken: String, completion: @escaping (PaymentData) -> (),Sendempety: @escaping (Bool) -> ()) {
        
        
        let cancelLabel = provider.request(.AddPayment(paymenttoken: Paymenttoken)) {
            result in
            switch result {
            case .success(let response):
                do {
                   print(response.statusCode)
                   
                    
                    switch response.statusCode {
                    case StatusCode.complete.rawValue:
                        let response =  try response.mapObject(PaymentData.self)
                        print(response)
                        completion(response)
                        myLoader.hideCustomLoader()
                        myLoader.hideCustomLoader()
                        myLoader.hideCustomLoader()
                   
                    case 400:
                        Sendempety(true)
                        myLoader.hideCustomLoader()
                        myLoader.hideCustomLoader()
                        myLoader.hideCustomLoader()
                    case 500:
                        do {
                            print(response.statusCode)
                            try print(response.mapJSON())
                            DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "Something went wrong".localized())
                            myLoader.hideCustomLoader()
                            myLoader.hideCustomLoader()
                        }
                    default:
                     
                            Alert.showError(response)
                            myLoader.hideCustomLoader()
                         myLoader.hideCustomLoader()
                         myLoader.hideCustomLoader()
                        
                    }
                    
                } catch {
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "Something went wrong".localized())
                    myLoader.hideCustomLoader()
                    myLoader.hideCustomLoader()
                }
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                 myLoader.hideCustomLoader()
                myLoader.hideCustomLoader()
              
            }
        }
        
    }
    
   
    
    
    func GetMyPayment( completion: @escaping ([PaymentData]) -> (),Sendempety: @escaping (Bool) -> ()) {
        
        
        let cancelLabel = provider.request(.GetMyPayment()) {
            result in
            switch result {
            case .success(let response):
                do {
                    print(response.statusCode)
                    do {
                        try print(response.mapJSON())
                    }
                    
                    switch response.statusCode {
                    case StatusCode.complete.rawValue:
                        let response =  try response.mapArray(PaymentData.self)
                        print(response)
                        completion(response)
                        
                    case 400:
                        Sendempety(true)
                    default:
                       
                            Alert.showError(response)
                            myLoader.hideCustomLoader()
                        
                    }
                    
                } catch {
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "Something went wrong".localized())
                    myLoader.hideCustomLoader()
                }
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                myLoader.hideCustomLoader()
                
            }
        }
        
    }
    
    
    func SetdefultePayment(paymentid:String, completion: @escaping (Bool) -> ()) {
        
        
        let cancelLabel = provider.request(.SetdefultePayment(paymentid:paymentid )) {
            result in
            switch result {
            case .success(let response):
                do {
                    print(response.statusCode)
                    do {
                        try print(response.mapJSON())
                    }
                    
                    switch response.statusCode {
                    case StatusCode.complete.rawValue:
                        
                        print(response)
                        completion(true)
                        
                    
                    default:
                       
                            Alert.showError(response)
                            myLoader.hideCustomLoader()
                        
                    }
                    
                } catch {
                   completion(true)
                    myLoader.hideCustomLoader()
                }
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                myLoader.hideCustomLoader()
                
            }
        }
        
    }
    
    
    
    func DeletePayment(paymentid:String, completion: @escaping (Bool) -> ()) {
        
        
        let cancelLabel = provider.request(.DeletePayment(paymentid: paymentid)) {
            result in
            switch result {
            case .success(let response):
                do {
                    print(response.statusCode)
                    do {
                        try print(response.mapJSON())
                    }
                    
                    switch response.statusCode {
                    case StatusCode.complete.rawValue:
                        
                        print(response)
                        completion(true)
                        
                        
                    default:
                        
                            Alert.showError(response)
                            myLoader.hideCustomLoader()
                        
                    }
                    
                } catch {
                    completion(true)
                    myLoader.hideCustomLoader()
                }
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                myLoader.hideCustomLoader()
                
            }
        }
        
    }
    
    
    
   
    
}
