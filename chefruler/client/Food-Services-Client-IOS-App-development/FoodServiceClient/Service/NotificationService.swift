//
//  NotificationService.swift
//  FoodServiceProvider
//
//  Created by Index on 2/19/18.
//  Copyright © 2018 index-pc. All rights reserved.
//
import UIKit
import Moya_Gloss
import Moya
import Localize_Swift
public enum NotificationService {
    //MARK:- notification

    case subscribeNotification(token: String)
    case unsubscribeNotification(token: String)
    case updateNotificationToken(newToken: String, oldToken: String)
    case getNotification(page: Int, limit: Int)
    case updateSeenNotification(id: Int)
    
}

extension NotificationService: TargetType {
    public var baseURL: URL { return URL(string: BASEURL)! }
    
    public var parameters: [String : Any]? {
        switch self {
        case .subscribeNotification(let token):
            return ["token": token]
        case .unsubscribeNotification(let token):
            return ["token": token]
        case .updateNotificationToken(let newToken, let oldToken):
            return ["oldToken": oldToken,
                    "newToken": newToken]
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        
        return JSONEncoding.default
    }
    
    public var path: String {
        switch self {
        case .subscribeNotification(_):
            return "/push-subscribe"
        case .unsubscribeNotification(_):
            return "/push-unsubscribe"
        case .updateNotificationToken(_):
            return "/push-update"
        case .getNotification(let page, let limit):
            return "/notifications?page=\(page)&limit=\(limit)"
        
        case .updateSeenNotification(let id):
            return "/notifications/\(id)/seen"
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
            
        case .getNotification:
            return .get
        case .updateSeenNotification:
            return .put
        default:
            return .post

        }
    }
        
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
            
        case .getNotification, .updateSeenNotification:
            return .requestPlain
        default:
            return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)

        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type":"application/json", "Accept-Language": Localize.currentLanguage()]
    }
    
    
}
