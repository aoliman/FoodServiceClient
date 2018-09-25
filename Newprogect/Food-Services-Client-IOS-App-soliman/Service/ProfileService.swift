//
//  ProfileService.swift
//  FoodServiceProvider
//
//  Created by Index on 1/9/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Moya_Gloss
import Moya
import Localize_Swift
public enum ProfileService
{
    ///api/v1/userNotification/2
    case getClientProfile(token: String,id: Int)
    //  case getNotification(token: String,id: Int)
    
    case changePassword(id: Int, password: String)
    case editProfile(token: String , id:Int, name:String,phone:String,user_address:String , place_image:String)
    case editProfileLocation(token: String , id:Int,lat :Float,long:Float )
    
    case updatePlacePhoto(id:Int, place_image: [[String: String]])
    
    //new api
    //    case getDeliverPlaceNearSpecificCenter(token: String, long: Float, lat: Float, raduis: Double, page: Int, limit: Int)
    
    //MARK:- api for delivery Place
    case getPlaceImages(token: String, id: Int)
    case addPlaceImages(token: String, id: Int , Images:[Data]?)
    case deletePlaceImage(index:Int, token: String, id: Int)
    
    
    //MARK:- notification
    case getNotification(token: String, page: Int, limit: Int)
    
    //Edit To image profile
    case UpdateImageProfile(data:Data , Userid:Int)
    
}

extension ProfileService: TargetType {
    
    public var baseURL: URL { return URL(string: BASEURL)! }
    
    public var parameters: [String : Any]?
    {        switch self
    {
    case .getClientProfile:
        return nil
        
    case .getNotification(_, let page , let limit):
        return ["page":page,"limit":limit]
    //
    case .changePassword(let id, let password):
        return ["id": id, "password": password]
    case .editProfile(_,let id , let name,let phone,let user_address ,let  place_image):
        return ["id":id,"name":name,"phone":phone,
                "user_address":user_address ,"place_image":place_image]
    case .updatePlacePhoto(let id ,let  place_image):
        return ["id":id,"place_image":place_image]
    case .editProfileLocation(_,let id ,let lat ,let long):
        return ["id":id,"lat":lat,"lant":long]
    case .getPlaceImages,.deletePlaceImage:
        return nil
    case .addPlaceImages(_, _ , _):
        var photosArray = [Any]()
        for multipartBody in self.multipartBody!
        {
            photosArray.append(multipartBody.provider)
        }
        
        return  ["images": photosArray as Any]
    case .UpdateImageProfile(let data,let  Userid):
        return ["profileImg": (multipartBody?[0].provider)!]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self
        {
        case .getClientProfile :
            return URLEncoding.default
            
        case .getNotification :
            return URLEncoding.default

        default:
            return JSONEncoding.default
            
        }
    }
    
    var multipartBody: [MultipartFormData]?
    {
        var multiPart = [MultipartFormData]()
        
        switch self
        {
        case .addPlaceImages(_, let id, let Images):
            if let placeImageData = Images
            {
                for image in placeImageData
                {
                    multiPart.append(MultipartFormData(provider: .data(image), name: "images", fileName: "\(String(describing: id)).jpg", mimeType:"image/*"))
                }
                return multiPart
            }
            return nil
            
          
        case .UpdateImageProfile(let data, let Userid):
            return [MultipartFormData(provider: .data(data), name: "profileImg", fileName: "\(Userid).jpg",
                mimeType: "image/jpeg")]
            
            
        default :
            return nil
        }
        
    }
    
    public var path: String
    {
        
        switch self
        {
        case .getClientProfile(_, let id):
            return "api/v1/firstTabProfile/\(id)/get"
            
        case .changePassword:
            return "/api/v1/changePassword"
        case .editProfile:
            return "/api/v1/userUpdate"
        case .updatePlacePhoto:
            return "/api/v1/signupPlacePhotoUpdate"
        case .editProfileLocation:
            return "/api/v1/signupLatLan"

        case .getPlaceImages(_, let id):
            return "/place-images"
        case .deletePlaceImage(let index, _ , let id):
            return "/place-images/\(index)"
        case .addPlaceImages(_, let id, _):
            return "/place-images"
            
        case .getNotification(_ ,  _ , _ ):
            return "/notifications"
        case .UpdateImageProfile(_,let Userid) :
            return "/clients/\((Singeleton.userInfo?.id)!)/profile-image"
        }
    }
    
    public var method: Moya.Method
    {
        switch self
        {
        case .getClientProfile,.getPlaceImages:
            return .get
            
        case .getNotification:
            return .get
        case .changePassword,.editProfileLocation:
            return .post
        case .editProfile,.updatePlacePhoto , .UpdateImageProfile:
            return .put

        case .deletePlaceImage( _ , _ ,_ ):
            return  .delete
        case .addPlaceImages( _ , _ ,_):
            return .post
        }
        
        
    }
    
    public var task: Task
    {
        switch self
        {
            
        case .getClientProfile ,.changePassword,.editProfile,.updatePlacePhoto,.editProfileLocation,.getPlaceImages,.deletePlaceImage:
            return .requestPlain
        case .getNotification:
            return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
        case .addPlaceImages:
            var multipartFormData = [MultipartFormData]()
            
            multipartFormData.append(contentsOf: self.multipartBody!)
            
            return .uploadMultipart(multipartFormData)
        case .UpdateImageProfile(let data, _):
           return .uploadMultipart(self.multipartBody!)
            
        }
    }
    
    
    public var sampleData: Data
    {
        return Data()
        
    }
    
    public var headers: [String: String]?
    {
        switch self
        {
        case .getClientProfile(let token,_),.editProfileLocation(let token,_,_,_),.editProfile(let token,_,_,_,_,_):
            return ["Content-Type":"application/json", "Authorization": "Bearer \(token)"]
            
            
        case .changePassword:
            return ["Content-Type":"application/json"]
            
        case .updatePlacePhoto:
            return ["Content-Type":"application/json"]
        
        case .getPlaceImages(let token, _):
            return ["Content-Type":"application/json", "Authorization": "Bearer \(token)", "Accept-Language": Localize.currentLanguage()]
        case .deletePlaceImage(_ , let token, _ ):
            return ["Content-Type":"application/json", "Authorization": "Bearer \(token)", "Accept-Language": Localize.currentLanguage()]
        case .addPlaceImages(let token, _, _):
            return ["Content-Type":"application/json", "Authorization": "Bearer \(token)", "Accept-Language": Localize.currentLanguage()]
        case .getNotification(let token, let page, let limit):
            return Singeleton.tokenHeaders
        case .UpdateImageProfile:
           return ["Content-Type":"application/json", "Authorization": "Bearer \(Singeleton.token)", "Accept-Language": Localize.currentLanguage()]
            
        }
    }
}


