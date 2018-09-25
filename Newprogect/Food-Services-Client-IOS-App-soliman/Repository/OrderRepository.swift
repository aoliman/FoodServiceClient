//
//  OrderRepo.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Moya_Gloss
import Moya

class OrderRepository
{
    var orderProvider = MoyaProvider<OrderService>()
    typealias OrderHandler = (OrderResponseApi,Int) -> ()
    typealias failureHandler = (ErrorResponse?,Int) -> Void

    init()
    {
        let endpointClosure = { (target: OrderService) -> Endpoint<OrderService> in
            
            let url = target.baseURL.absoluteString.appending(target.path)
            
            return Endpoint(url:  url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: Singeleton.tokenHeaders)
        }
        
        orderProvider = MoyaProvider<OrderService>(endpointClosure: endpointClosure)
    }
    
    func getOrders(page:Int , limit:Int, status: String?, onSuccess: @escaping OrderHandler ,onFailure: @escaping failureHandler)
    {
        let id = Singeleton.userInfo?.id
       let cancellabel = orderProvider.request(.getOrders(id: id!, page: page, limit: limit, status: status)) {
            (result) in
            switch result {
                case .success(let response):
                do {
                switch response.statusCode {
                case StatusCode.success.rawValue:
                let responseApi =  try response.mapObject(OrderResponseApi.self)
                onSuccess(responseApi, response.statusCode)
              
                case StatusCode.complete.rawValue:
                let responseApi =  try response.mapObject(OrderResponseApi.self)
                onSuccess(responseApi, response.statusCode)
                    
                default:
                let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                onFailure(errorResponseApi, response.statusCode)
                }
                } catch {
                onFailure(nil, 404)
                }
                
                case .failure(_):
                onFailure(nil, 404)
                }
            }
        cancellabelArry.append(cancellabel)
        }
    
    
    
    func updateOrderStatus(cookerType:String,orderId: Int, stauts: String , userId:Int, onSuccess: @escaping (Int) -> (),onFailure: @escaping failureHandler) {
        orderProvider.request(.updateOrderStatus(CookerType: cookerType, userId:userId , orderId: orderId, status: stauts)) { (result) in
            switch result {
            case .success(let response):
                do {

                    switch response.statusCode {
                    case StatusCode.undocumented.rawValue:

                        onSuccess(response.statusCode)

                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)

                    }
                } catch {
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "Error Mapping Object".localized())
                }
            case .failure(let error):
                print(error)
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())

            }
        }
    }
    
    
    
    
    
    
    func getSingleOrder(orderId: Int, stauts: String , userId:Int, onSuccess: @escaping (OrderData) -> (),onFailure: @escaping failureHandler) {
        
        orderProvider.request(   .getSingleOrder(userId: userId, orderId: orderId, status: "")  ) { (result) in
            switch result {
            case .success(let response):
                do {
                    
                    switch response.statusCode {
                    case StatusCode.complete.rawValue,StatusCode.success.rawValue:
                        let respnseapisucess = try response.mapObject(OrderData.self)
                      
                        onSuccess(respnseapisucess)
                        
                    default:
                        Alert.showError(response)
                        myLoader.hideCustomLoader()
                        
                    }
                } catch {
                    DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "Error Mapping Object".localized())
                }
            case .failure(let error):
                print(error)
                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                
            }
        }
    }
    
    
    
    
    
    
}



