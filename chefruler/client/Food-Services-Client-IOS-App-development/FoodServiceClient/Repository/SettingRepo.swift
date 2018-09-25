//
//  SettingRepo.swift
//  FoodServiceProvider
//
//  Created by Index on 2/27/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Moya_Gloss
import Moya

class SettingRepo {
    var settingProvider = MoyaProvider<SettingService>()
    let token = UserDefaults.standard.string(forKey: defaultsKey.token.rawValue)
    let userId = UserDefaults.standard.integer(forKey: defaultsKey.userId.rawValue)
    let language = UserDefaults.standard.string(forKey: defaultsKey.language.rawValue)
    
    typealias EditProfileHandler = (EditProfileResponse, Int) -> ()
    typealias failureHandler = (ErrorResponse?,Int) -> Void

    
    init() {
        let endpointClosure = { (target: SettingService) -> Endpoint<SettingService> in
            
            let url = target.baseURL.absoluteString.appending(target.path)
            
            return Endpoint(url:  url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: ["Content-Type": "application/json", "Authorization": "Bearer \(self.token!)", "Accept-Language": self.language!])
        }
        
        settingProvider = MoyaProvider<SettingService>(endpointClosure: endpointClosure)
    }
    
    
    func editProfile(name: String, email: String, phone: String, currentPassword: String?, newPassword: String?, onSuccess: @escaping EditProfileHandler , onFailure: @escaping failureHandler) {
        settingProvider.request(.editProfile(name: name, email: email, phone: phone, currentPassword: currentPassword, newPassword: newPassword)) { (result) in
           
            switch result {
            case .success(let response):
               print(response.statusCode) 
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:

                        
                        let profileResponse =  try response.mapObject(EditProfileResponse.self)
                        onSuccess(profileResponse, response.statusCode)
                        
                    case StatusCode.complete.rawValue:

                        let profileResponse =  try response.mapObject(EditProfileResponse.self)
                        onSuccess(profileResponse, response.statusCode)

                        
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
}
