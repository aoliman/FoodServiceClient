//
//  ChatService.swift
//  FoodServiceProvider
//
//  Created by Index on 1/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Moya_Gloss
import Moya

public enum ChatService {
    case getClientChat(token: String,id: Int, page: Int, limit: Int)
    case changeOnlineStatus(token: String, online: Bool)
}

extension ChatService: TargetType {
    
    public var parameters: [String : Any]? {
        switch self {
            case .getClientChat:
                return nil
            case .changeOnlineStatus(_ ,  let online):
                return ["online": online]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        
        return JSONEncoding.default
    }
    
    public var baseURL: URL { return URL(string: BASEURL)! }
    
    public var path: String {
        switch self {
            case .getClientChat(_, let id, let page , let limit):
                return "/api/v1/getClientChat/\(id)?page=\(page)&limit=\(limit)"
            case .changeOnlineStatus:
                return "/online"
        }
    }
    public var method: Moya.Method {
        switch self {
            case .getClientChat:
                return .get
            
            case .changeOnlineStatus:
                return .put
        }
    }
    
    public var task: Task {
        
        switch self {
            case .getClientChat:
                return .requestPlain

             case .changeOnlineStatus:
                return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)

        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
       
            return ["Content-Type":"application/json"]
    }
}

