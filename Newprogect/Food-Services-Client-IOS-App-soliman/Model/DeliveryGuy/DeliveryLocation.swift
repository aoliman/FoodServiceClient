//
//	Location.swift
//
//	Create by Index on 7/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - Location
public struct DeliveryLocation: Glossy {

	public let lat : String!
	public let lng : String!



	//MARK: Decodable
	public init?(json: JSON){
		lat = "lat" <~~ json
		lng = "lng" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"lat" ~~> lat,
		"lng" ~~> lng,
		])
	}

}
