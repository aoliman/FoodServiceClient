//
//	RootClass.swift
//
//	Create by index-ios on 3/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct CreatOrderRes: Glossy {

	public let client : Client!
	public let clientDeliveryType : String!
	public let cooker : Client!
	public let cookerDeliveryType : String!
	public let creationDate : String!
	public let deliveryDate : Int!
	public let deliveryPlace : Client!
	public let id : Int!
	public let kind : String!
	public let productOrders : [ProductOrderRes]!
	public let status : String!
	public let totalPrice : Float!



	//MARK: Decodable
	public init?(json: JSON){
		client = "client" <~~ json
		clientDeliveryType = "clientDeliveryType" <~~ json
		cooker = "cooker" <~~ json
		cookerDeliveryType = "cookerDeliveryType" <~~ json
		creationDate = "creationDate" <~~ json
		deliveryDate = "deliveryDate" <~~ json
		deliveryPlace = "deliveryPlace" <~~ json
		id = "id" <~~ json
		kind = "kind" <~~ json
		productOrders = "productOrders" <~~ json
		status = "status" <~~ json
		totalPrice = "totalPrice" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"client" ~~> client,
		"clientDeliveryType" ~~> clientDeliveryType,
		"cooker" ~~> cooker,
		"cookerDeliveryType" ~~> cookerDeliveryType,
		"creationDate" ~~> creationDate,
		"deliveryDate" ~~> deliveryDate,
		"deliveryPlace" ~~> deliveryPlace,
		"id" ~~> id,
		"kind" ~~> kind,
		"productOrders" ~~> productOrders,
		"status" ~~> status,
		"totalPrice" ~~> totalPrice,
		])
	}

}
