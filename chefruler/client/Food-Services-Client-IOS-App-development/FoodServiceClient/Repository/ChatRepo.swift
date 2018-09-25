//
//  ChatRepo.swift
//  FoodServiceProvider
//
//  Created by Index on 1/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Moya_Gloss
import Moya

class ChatRepo {
    
    var chatProvider = MoyaProvider<ChatService>()
    let token = UserDefaults.standard.string(forKey: defaultsKey.token.rawValue)
    let userId = UserDefaults.standard.integer(forKey: defaultsKey.userId.rawValue)
    let language = UserDefaults.standard.string(forKey: defaultsKey.language.rawValue)

    init() {
        let endpointClosure = { (target: ChatService) -> Endpoint<ChatService> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields:  ["Content-Type": "application/json", "Authorization": "Bearer \(self.token!)", "Accept-Language": self.language!])
            
        }
        
        chatProvider = MoyaProvider<ChatService>(endpointClosure: endpointClosure)
    }
    
    
    public func getClientChat( page:Int , limit:Int, completion: @escaping (ChatModel) -> ()) {
        
        chatProvider.request(.getClientChat(token: token!, id: userId, page: page, limit: limit)) {
            result in
            print(result)
            switch result {
            case .success(let response):
                do {
                    let user =  try response.mapObject(ChatModel.self)
                    completion(user)
                    Loader.hideLoader()

                } catch {
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                    Loader.hideLoader()
                    
                }
                
            case .failure(_):
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                Loader.hideLoader()
            }
        }
    }
    
    public func getOnlineStatus(online: Bool, completion: @escaping (Int) -> ()) {
        chatProvider.request(.changeOnlineStatus(token: token!, online: online)) {
            result in
            switch result {

                case .success(let response):
                    completion(response.statusCode)
                
                case .failure(_):
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
            }
        }
    }
    
}

