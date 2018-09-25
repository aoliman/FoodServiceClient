//
//  OrderService.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Moya_Gloss
import Moya
import Localize_Swift
public enum OrderService
{
    case getOrders(id: Int, page: Int, limit: Int,status: String?)
    case updateOrderStatus(CookerType:String,userId: Int, orderId: Int, status: String)
    case rateOrder(userId: Int, orderId: Int, rate: Int)
    case getSingleOrder(userId: Int, orderId: Int, status: String)


}

extension OrderService: TargetType
{
    public var parameters: [String : Any]? {
        switch self {
            case .getOrders:
                return nil
            case .updateOrderStatus(_,_, _, let status):
                return ["status": status]
        case .rateOrder( _ , _ , let rate ):
                return ["rate":rate]
        default:
            return [:]
            
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

   
    
    public var baseURL: URL { return URL(string: BASEURL)! }
    public var path: String {
        
        switch self {
            case .getOrders(let userId, let page, let limit, let status):
                if let val = status {
                    return "/clients/\(userId)/orders?page=\(page)&limit=\(limit)&status=\(val)"
                } else {
                    return "/clients/\(userId)/orders?page=\(page)&limit=\(limit)"
                }
        case .updateOrderStatus(let cooketType, let userId, let orderId, _):
                return "/\(cooketType)/\(userId)/orders/\(orderId)/status"

        case .rateOrder(let userId, let orderId,_ ):
            return "/clients/\(userId)/orders/\(orderId)/rate"

        case .getSingleOrder(let userId, let orderId, _ ):
            return "/clients/\(userId)/orders/\(orderId)"

        }

    }
    
    public var method: Moya.Method {
        switch self {
            case .getOrders:
                return .get
            case .updateOrderStatus:
                return .put
            case .rateOrder:
                return .put
           case .getSingleOrder:
                return .get
        }
    }
    
    
    public var task: Task {
        switch self {
            case .getOrders:
                return .requestPlain

            case .updateOrderStatus:
                return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
           
           case .rateOrder:
                return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
          
          case .getSingleOrder:
               return .requestPlain

        }
    }
    
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return Singeleton.tokenHeaders
    }
}


