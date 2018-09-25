//
//  UserService.swift
//  FoodServiceClient
//
//  Created by Index PC-2 on 3/5/18.
//  Copyright © 2018 Index. All rights reserved.
//

import Foundation
import Moya
import Moya_Gloss
import Localize_Swift
public enum UserService
{
    
    //Login service Api
    case login(email: String, password: String)
    case verifyCode(id: Int, verify_code: String)
    case changePassword(id: Int, password: String)
    case updatePhone(id: Int, phone: String)
    
    //forget password
    case verifyCodeChangfePassword(phone: String, verify_code: String)
    case forgetPasswordPhone(phone: String)
    case resetPasswordPhone(newPassword:String, phone: String)

    //register service Api
    case signup(name: String, email: String, password: String , phone: String,user_address: String,user_type: String)
    case continueRegisterProfileImage(id: Int, images: [Data])
    case continueRegisterCreditCardInfo(id: Int,credit_card_number: String,credit_card_password: String, credit_card_finish_year: Int, credit_card_finish_month: Int, name_in_credit_card: String,country: String,
        postal_code: String)
    case continueRegisterLocation(id: Int, lat: Double , lan: Double)


    

}

extension UserService: TargetType{
    public var baseURL: URL {
       return URL(string: BASEURL)!
    }
    
    public var path: String {
        switch self
        {
        case .login:
            return "/signin"
            
        case .forgetPasswordPhone:
            return "/forget-password"
            
        case .verifyCode(let id, _):
            return "/clients/\(id)/verify-code"
            
        case .changePassword:
            return "/changePassword"
            
        case .updatePhone:
            return "/phoneRegister"
            
        case .signup(_ , _ , _ , _ , _ , _ ):
            return "/signup"
            
        case .continueRegisterCreditCardInfo(let id, _, _,_,_, _, _, _):
            return "/clients/\(id)/credit-card"
            
        case .continueRegisterProfileImage(let id , _ ):
            return "/clients/\(id)/profile-image"
            
        case .continueRegisterLocation(let id, _ , _ ):
             return "/clients/\(id)/location"
        case .verifyCodeChangfePassword(let id, let password):
            return "/verify-code"
        case .resetPasswordPhone(let newPassword, let phone):
            return "/reset-password"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signup,.login,.verifyCode,.verifyCodeChangfePassword:
            return .post
            
        default:
            return .put
        }
    }
    
    
    public var parameters: [String : Any]?
    {
        switch self
        {
        case .login(let email, let password):
            return ["email": email, "password": password]
            
        case .forgetPasswordPhone(let phone):
            return ["phone": phone]
            
        case .verifyCode(_ , let verify_code):
            return ["verifyCode": verify_code]
            
        case .changePassword(let id, let password):
            return ["id": id, "password": password]
            
        case .updatePhone(let id, let phone):
            return ["id": id, "phone": phone]
            
        case .signup(let name, let email, let password, let phone, let user_address, let ـ ):
            return ["name" : name, "email": email, "password": password, "phone": phone,"address": user_address,"type": "CLIENT"]
            
        case .continueRegisterProfileImage(_ , _ ):
            return ["image": (multipartBody?[0].provider)!]
            
        case .continueRegisterCreditCardInfo(_ , let credit_card_number, let credit_card_password, let credit_card_finish_year, let credit_card_finish_month, let name_in_credit_card, let country, let postal_code):
            return ["number": credit_card_number, "password": credit_card_password, "finishYear": credit_card_finish_year, "finishMonth": credit_card_finish_month, "nameInCard": name_in_credit_card, "country": country, "postalCode": postal_code]
            
            
        case .continueRegisterLocation(_ , let lat, let lan):
                return ["lat": lat, "lng": lan]
        case .verifyCodeChangfePassword(let phone, let verify_code):
            return ["phone": phone , "verifyCode":verify_code]

        case .resetPasswordPhone(let newPassword, let phone):
            return ["phone": phone , "newPassword":newPassword]

        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self
        {
        case .continueRegisterProfileImage(_ , _ ):
            return .uploadMultipart(self.multipartBody!)
        default:
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)

        }
    }
    
    
    
    var multipartBody: [MultipartFormData]?
    {
        
        switch self
        {
        case .continueRegisterProfileImage(let id ,let  images ):
            return [MultipartFormData(provider: .data(images[0]), name: "image", fileName: "\(id).jpg",
                mimeType: "image/jpeg")]
            
            
        default:
            return []
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
       case .verifyCode:
        return Singeleton.tokenHeaders
        default:
        return Singeleton.defaultHeaders

        }
    }
    
    
}
