//
//	RootClass.swift
//
//	Create by index-ios on 27/3/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct HomeCookerPlacemodel: Glossy {

	public let cooker : Int!
	public let creationDate : String!
	public let deliveryPlace : DeliveryPlace!
	public let id : Int!
	public let status : String!



	//MARK: Decodable
	public init?(json: JSON){
		cooker = "cooker" <~~ json
		creationDate = "creationDate" <~~ json
		deliveryPlace = "deliveryPlace" <~~ json
		id = "id" <~~ json
		status = "status" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"cooker" ~~> cooker,
		"creationDate" ~~> creationDate,
		"deliveryPlace" ~~> deliveryPlace,
		"id" ~~> id,
		"status" ~~> status,
		])
	}

}
