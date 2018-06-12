//
//	RootClass.swift
//
//	Create by index-ios on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct PartyCookerResponse: Glossy {

	public let appointmentDate : Int!
	public let client : Client!
	public let cooker : Int!
	public let cookingLocation : [Float]!
	public let creationDate : String!
	public let id : Int!
	public let individualPrice : Int!
	public let individualsCount : Int!
	public let kind : String!
	public let productOrders : [ProductOrderPartycooker]!
	public let status : String!
	public let totalPrice : Int!



	//MARK: Decodable
	public init?(json: JSON){
		appointmentDate = "appointmentDate" <~~ json
		client = "client" <~~ json
		cooker = "cooker" <~~ json
		cookingLocation = "cookingLocation" <~~ json
		creationDate = "creationDate" <~~ json
		id = "id" <~~ json
		individualPrice = "individualPrice" <~~ json
		individualsCount = "individualsCount" <~~ json
		kind = "kind" <~~ json
		productOrders = "productOrders" <~~ json
		status = "status" <~~ json
		totalPrice = "totalPrice" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"appointmentDate" ~~> appointmentDate,
		"client" ~~> client,
		"cooker" ~~> cooker,
		"cookingLocation" ~~> cookingLocation,
		"creationDate" ~~> creationDate,
		"id" ~~> id,
		"individualPrice" ~~> individualPrice,
		"individualsCount" ~~> individualsCount,
		"kind" ~~> kind,
		"productOrders" ~~> productOrders,
		"status" ~~> status,
		"totalPrice" ~~> totalPrice,
		])
	}

}
