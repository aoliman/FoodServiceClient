//
//	RootClass.swift
//
//	Create by index-ios on 10/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct DeliveryGuyInfoRes: Glossy {

	public let accepted : Bool!
	public let address : String!
	public let email : String!
	public let fieldEmpty : Int!
	public let id : Int!
	public let lang : String!
	public let language : String!
	public let location : Location!
	public let lock : Bool!
	public let name : String!
	public let online : Bool!
	public let phone : String!
	public let profileImg : String!
	public let profileImgs : [String]!
	public let rating : Float!
	public let type : String!
	public let userCardImgs : [String]!
	public let userLicenseImg : String!
	public let vehicleLicenseImg : String!



	//MARK: Decodable
	public init?(json: JSON){
		accepted = "accepted" <~~ json
		address = "address" <~~ json
		email = "email" <~~ json
		fieldEmpty = "field_empty" <~~ json
		id = "id" <~~ json
		lang = "lang" <~~ json
		language = "language" <~~ json
		location = "location" <~~ json
		lock = "lock" <~~ json
		name = "name" <~~ json
		online = "online" <~~ json
		phone = "phone" <~~ json
		profileImg = "profileImg" <~~ json
		profileImgs = "profileImgs" <~~ json
		rating = "rating" <~~ json
		type = "type" <~~ json
		userCardImgs = "userCardImgs" <~~ json
		userLicenseImg = "userLicenseImg" <~~ json
		vehicleLicenseImg = "vehicleLicenseImg" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"accepted" ~~> accepted,
		"address" ~~> address,
		"email" ~~> email,
		"field_empty" ~~> fieldEmpty,
		"id" ~~> id,
		"lang" ~~> lang,
		"language" ~~> language,
		"location" ~~> location,
		"lock" ~~> lock,
		"name" ~~> name,
		"online" ~~> online,
		"phone" ~~> phone,
		"profileImg" ~~> profileImg,
		"profileImgs" ~~> profileImgs,
		"rating" ~~> rating,
		"type" ~~> type,
		"userCardImgs" ~~> userCardImgs,
		"userLicenseImg" ~~> userLicenseImg,
		"vehicleLicenseImg" ~~> vehicleLicenseImg,
		])
	}

}
