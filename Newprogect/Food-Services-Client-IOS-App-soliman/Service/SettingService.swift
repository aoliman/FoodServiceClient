//
//  SettingService.swift
//  FoodServiceProvider
//
//  Created by Index on 2/27/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Moya_Gloss
import Moya
import Localize_Swift
public enum SettingService {
    
    case editProfile(name: String, email: String, phone: String, currentPassword: String?, newPassword: String?)
}

extension SettingService: TargetType {
    public var parameters: [String : Any]? {
        
        switch self {
            case .editProfile(let name, let email, let phone, let currentPassword, let newPassword):
                return [ "name": name,
                         "email": email,
                         "phone": phone,
                         "currentPassword": currentPassword as Any,
                         "newPassword": newPassword as Any]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    
    
    public var baseURL: URL { return URL(string: BASEURL)! }
    
    public var path: String {
        switch self {
            case .editProfile:
            return "/profile"
            
        }
        
        
    }
    
    public var method: Moya.Method {
        switch self {
            case .editProfile:
                return .put
        }
    }
    
    
    public var task: Task {
        switch self {
            
            case .editProfile:
                return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
            
        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        
        return ["Content-Type": "application/json", "Accept-Language": Localize.currentLanguage()]
    }
}

