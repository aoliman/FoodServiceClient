//
//  StatusCode.swift
//  FoodServiceProvider
//
//  Created by Index on 1/15/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Localize_Swift

enum StatusCode: Int
{
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case notAcceptable = 406
    case unsupportedMediaType = 415
    case tooManyRequests = 429
    case serverError = 500
    case unprocessableEntity = 422
    case complete = 200
    case success = 201
    case undocumented = 204

}


enum DeliveryHome: String {
    case No = "no"
    case yes = "yes"
}
