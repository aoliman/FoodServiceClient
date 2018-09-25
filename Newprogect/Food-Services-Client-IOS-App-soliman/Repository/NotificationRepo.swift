
//  NotificationRepo.swift
//  FoodServiceProvider
//
//  Created by Index on 2/19/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Moya_Gloss
import Moya

class NotificationRepo {
    
    var notificationRepo = MoyaProvider<NotificationService>()
    let token = UserDefaults.standard.string(forKey: defaultsKey.token.rawValue)
    let fcmToken = UserDefaults.standard.string(forKey: defaultsKey.fcmToken.rawValue)
    let language = UserDefaults.standard.string(forKey: defaultsKey.language.rawValue)

    init() {
        let endpointClosure = { (target: NotificationService) -> Endpoint<NotificationService> in
            
            let url = target.baseURL.absoluteString.appending(target.path)
            print(url)
            return Endpoint(url:  url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: ["Content-Type": "application/json", "Authorization": "Bearer \(self.token!)", "Accept-Language": self.language!])
        }
        
        notificationRepo = MoyaProvider<NotificationService>(endpointClosure: endpointClosure)
    }
    
    public func getNotification(page:Int , limit:Int,completion: @escaping (UserNotificationResponseApi, Int) -> ()) {
        
        notificationRepo.request(.getNotification(page: page, limit: limit)) {
            result in
            switch result {
                
            case .success(let response):
                print(response)
                do {
                    switch response.statusCode {
                        
                    case StatusCode.complete.rawValue, StatusCode.success.rawValue:
                        let responseApi =  try response.mapObject(UserNotificationResponseApi.self)
                        completion(responseApi ,response.statusCode)
                        
                    default:
                      //  Alert.showError(response)
                        Loader.hideLoader()
//                        Loader.hideLoader()
//
//                        let errorResponse =  try response.mapObject(APIError.self)
//
//                        var error = errorResponse.error
//
//                        error = (error != nil ) ? error : errorResponse.generalError![0].msg
//
//                        Alert.showAlert(title: "Error".localized(), message: error!)
//                        print(response.statusCode, "Undefined error")
                    }
                
                } catch {
                    Loader.hideLoader()
                    print("Error mapping object")
                }
                
            case .failure(let err):
                Loader.hideLoader()
                print("Failure: \(err)")
            }
        }
        
        
    }
    
    func subscribeNotification() {
        notificationRepo.request(.subscribeNotification(token: fcmToken!)) {
            (result) in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode {
                        case StatusCode.success.rawValue, StatusCode.complete.rawValue:
                            print("Successfull notification subscribe")
                        
                        default:
                         //   Alert.showError(response)
//                            let errorResponse =  try response.mapObject(APIError.self)
//
//                            var error = errorResponse.error
//
//                            error = (error != nil ) ? error : errorResponse.generalError![0].msg
//
                          //  Alert.showAlert(title: "Error".localized(), message: error!)
                            print(response.statusCode, "Undefined error")
                    }
                } catch {}
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
            }
        
        }
    }
    
    func unSubscribeNotification() {
        
        if let token = fcmToken {
            
            notificationRepo.request(.unsubscribeNotification(token: token)) {
                (result) in
                switch result {
                case .success(let response):
                    
                    do {
                        switch response.statusCode {
                        case StatusCode.success.rawValue, StatusCode.complete.rawValue:
                            print("Successfull notification unsubscribe")
                            
                        default:
                            Alert.showError(response)
                            myLoader.hideCustomLoader()
                            //                        let errorResponse =  try response.mapObject(APIError.self)
                            //
                            //                        var error = errorResponse.error
                            //
                            //                        error = (error != nil ) ? error : errorResponse.generalError![0].msg
                            //
                            //                        Alert.showAlert(title: "Error".localized(), message: error!)
                            //                        print(response.statusCode, "Undefined error")
                        
                       
                        
                        }
                    } catch {
                        
                        
                        
                    }
                    
                case .failure(_):
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                }
                
            }
        }
    }
    
    func updateNotificationToken() {

        notificationRepo.request(.updateNotificationToken(newToken: fcmToken!, oldToken: fcmToken!)) {
            (result) in

            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode {
                    case StatusCode.success.rawValue, StatusCode.complete.rawValue:
                        print("Successfull notification update token")
                        
                    default:
                        let errorResponse =  try response.mapObject(APIError.self)
                        
                        var error = errorResponse.error
                        
                        error = (error != nil ) ? error : errorResponse.generalError![0].msg
                        
                      //  Alert.showAlert(title: "Error".localized(), message: error!)
                        print(response.statusCode, "Undefined error")
                    }
                } catch {
                    
              }
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
            }
        }
    }
    
    func updateSeenNotification(id: Int, completion: @escaping (Int) -> ()) {
        notificationRepo.request(.updateSeenNotification(id: id)) { (result) in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode {
                    case StatusCode.success.rawValue, StatusCode.complete.rawValue:
                        print("Successfull notification seen update")
                        completion(response.statusCode)
                        
                    default:
//                        let errorResponse =  try response.mapObject(APIError.self)
//
//                        var error = errorResponse.error
//
//                        error = (error != nil ) ? error : errorResponse.generalError![0].msg
//
//                        Alert.showAlert(title: "Error".localized(), message: error!)
                        print(response.statusCode, "Undefined error")
                    }
                } 
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
            }
        }
    }
}
