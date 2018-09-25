//
//  ProfileRepo.swift
//  FoodServiceProvider
//
//  Created by Index on 1/9/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Moya_Gloss
import Moya

class ProfileRespository:BaseRepository {
    var profileProvider = MoyaProvider<ProfileService>()
  
   // typealias profileHandler =  (ProfileResponseApi , Int) -> ()
    typealias NotificationHandler = (UserNotificationResponseApi , Int) -> ()
    typealias failureHandler = (ErrorResponse?,Int) -> Void

    override init()
    {
        let endpointClosure = { (target: ProfileService) -> Endpoint<ProfileService> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields: Singeleton.tokenHeaders)
        }
        
        profileProvider = MoyaProvider<ProfileService>(endpointClosure: endpointClosure)
    }
    
    
//    public func getProfile(completion:@escaping profileHandler)
//    {
//
//        profileProvider.request(.getClientProfile(token: Singeleton.token!, id: Singeleton.userId))
//        {
//            result in
//            switch result {
//            case .success(let response):
//                print(response)
//                do {
//                    let responseApi =  try response.mapObject(ProfileResponseApi.self)
//
//                    completion(responseApi ,response.statusCode)
//
//
//                } catch {
//                    print("Error mapping object")
//                }
//
//            case .failure(let err):
//                print("Failure: \(err)")
//            }
//        }
//
//    }
//
    
    public func getNotification(page: Int,limit: Int, onSuccess: @escaping NotificationHandler , onFailure: @escaping failureHandler)
    {
        
        profileProvider.request(.getNotification(token: Singeleton.token, page: page, limit: limit))
        {
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let responseApi =  try response.mapObject(UserNotificationResponseApi.self)
                        print(responseApi)
                        onSuccess(responseApi, response.statusCode)
                    
                    case StatusCode.complete.rawValue:
                        let responseApi =  try response.mapObject(UserNotificationResponseApi.self)
                        print(responseApi)
                        onSuccess(responseApi, response.statusCode)
                        
                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                        myLoader.hideCustomLoader()
                    }
                } catch {
                    onFailure(nil, 404)
                }
                
            case .failure(_):
                onFailure(nil, 404)
            }
        }
        
    }
    
    
//    func  getPlaceImage(completion: @escaping deliveryPlaceHandler) {
//        profileProvider.request(.getPlaceImages(token: token!, id: userId))
//        {
//            result in
//            switch result {
//            case .success(let response):
//                print(response)
//                do {
//                    let responseApi =  try response.mapObject(DeliveryPlaceResponseApi.self)
//                    completion(response.statusCode, responseApi)
//                } catch {
//                    completion(response.statusCode, nil )
//                    print("Error mapping object")
//                }
//            case .failure(let _):
//                completion(404, nil )
//            }
//        }
//
//    }
//
//    func deletePlaceImage(index: Int ,completion: @escaping deliveryPlaceHandler) {
//        profileProvider.request(.deletePlaceImage(index: index, token: token!, id: userId))
//        {
//            result in
//            switch result {
//            case .success(let response):
//                print(response)
//                do {
//                    let responseApi =  try response.mapObject(DeliveryPlaceResponseApi.self)
//                    completion(response.statusCode, responseApi)
//                } catch {
//                    completion(response.statusCode,nil)
//
//                    print("Error mapping object")
//                }
//            case .failure(let err):
//                print("Failure: \(err)")
//            }
//        }
//
//    }
//
//
//    func AddPlaceImage(Images: [Data] ,completion: @escaping deliveryPlaceHandler) {
//        profileProvider.request(.addPlaceImages(token: token!, id: userId, Images: Images))
//        {
//            result in
//            switch result {
//            case .success(let response):
//                print(response)
//                do {
//                    let responseApi =  try response.mapObject(DeliveryPlaceResponseApi.self)
//                    completion(response.statusCode, responseApi)
//                } catch {
//                    completion(response.statusCode,nil)
//
//                    print("Error mapping object")
//                }
//            case .failure(let err):
//                print("Failure: \(err)")
//            }
//        }
//
//    }
//
////    public func changePassword(id: Int, password: String, completion: @escaping (GeneralResponseModel,Int) -> ())
////    {
////        profileProvider.request(.changePassword(id: id, password: password))
////        {
////            result in
////
////
////            switch result {
////            case .success(let response):
////                do {
////                    let responseApi =  try response.mapObject(GeneralResponseModel.self)
////                    completion(responseApi ,response.statusCode)
////
////                } catch {
////                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
////
////                    Loader.hideLoader()
////                }
////
////            case .failure( _):
////                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
////                Loader.hideLoader()
////
////            }
////
////        }
////    }
//
//
////    public func changeProfile(id: Int, name: String, phone: String, user_address: String, place_image: String, completion: @escaping (GeneralResponseModel,Int) -> ())
////    {
////
////        profileProvider.request(.editProfile(token:token!,id: id, name: name, phone: phone, user_address: user_address, place_image: place_image))
////        {
////            result in
////
////
////            switch result {
////            case .success(let response):
////                do {
////                    let responseApi =  try response.mapObject(GeneralResponseModel.self)
////                    completion(responseApi ,response.statusCode)
////
////                } catch {
////                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
////
////                    Loader.hideLoader()
////                }
////
////            case .failure( _):
////                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
////                Loader.hideLoader()
////
////            }
////
////        }
////    }
//
//
//    public func changeProfileLocation(id: Int, lat: Float, long: Float, completion: @escaping (EditProfileResponseApi,Int) -> ())
//    {
//
//        profileProvider.request(.editProfileLocation(token: token!, id: id, lat: lat, long: long))
//        {
//            result in
//
//
//            switch result {
//            case .success(let response):
//                do {
//                    let responseApi =  try response.mapObject(EditProfileResponseApi.self)
//                    completion(responseApi ,response.statusCode)
//
//                } catch {
//                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
//
//                    Loader.hideLoader()
//                }
//
//            case .failure( _):
//                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
//                Loader.hideLoader()
//
//            }
//
//        }
//    }
//
//
//    public func changePlaceImages(id: Int, place_image:
//        [Data], completion: @escaping (Int) -> ())
//    {
////        profileProvider.request(.updatePlacePhoto(id: id, place_image: place_image))
////        {
////            result in
////
////
////            switch result {
////            case .success(let response):
////                do {
////                    let responseApi =  try response.mapObject(GeneralResponseModel.self)
////                    completion(responseApi ,response.statusCode)
////
////                } catch {
////                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
////
////                    Loader.hideLoader()
////                }
////
////            case .failure( _):
////                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
////                Loader.hideLoader()
////
////            }
//
////        }
//    }
    
    
  
    
//    public func getDeliverPlaceNearSpecificCenter( long: Float, lat: Float, raduis: Double, page: Int, limit: Int, completion: @escaping nearByHandler)
//    {
//        Loader.showLoader()
//        profileProvider.request(.getDeliverPlaceNearSpecificCenter(token: token!, long: long, lat: lat, raduis: raduis, page: page, limit: limit))
//        {
//            result in
//            Loader.hideLoader()
//            switch result {
//            case .success(let response):
//                do {
//                    switch response.statusCode
//                    {
//                        case StatusCode.complete.rawValue, StatusCode.success.rawValue:
//                            let deliverPlaceResponse =  try response.mapObject(DeliverPlaceNearsAPI.self)
//                            print(response)
//                            completion(response.statusCode,deliverPlaceResponse)
//
//                        default:
//                            let errorResponse =  try response.mapObject(APIError.self)
//
//                            var error = errorResponse.error
//
//                            error = (error != nil ) ? error : errorResponse.generalError![0].msg
//
//                            Alert.showAlert(title: "Error".localized(), message: error!)
//                            print(response.statusCode, "Undefined error")
//                    }
//
//
//
//                } catch {
//                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
//
//                    Loader.hideLoader()
//                }
//
//            case .failure( _):
//                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
//                Loader.hideLoader()
//
//            }
//
//        }
//    }
    
    public func UpdateProfileImage(id: Int, image:
            Data, completion: @escaping (User) -> ())
        {
            profileProvider.request(.UpdateImageProfile(data: image, Userid: id))
            {
                result in
    
    
                switch result {
                case .success(let response):
                    do {
                        print("response == \(try  response.mapJSON())")
                        let responseclient =  try response.mapObject(EditProfileResponse.self)
                        completion(responseclient.user)
    
                    } catch {
                       print("catch")
                    }
    
                case .failure( _):
                    print("failure")
    
                }
    
            }
        }
    
    
}

