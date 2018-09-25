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
public struct DeliveryGuyRes: Glossy {

	public let data : [FoodCarMapRes]!
	public let limit : Int!
	public let links : Link!
	public let page : Int!
	public let pageCount : Int!
	public let totalCount : Int!



	//MARK: Decodable
	public init?(json: JSON){
		data = "data" <~~ json
		limit = "limit" <~~ json
		links = "links" <~~ json
		page = "page" <~~ json
		pageCount = "pageCount" <~~ json
		totalCount = "totalCount" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"data" ~~> data,
		"limit" ~~> limit,
		"links" ~~> links,
		"page" ~~> page,
		"pageCount" ~~> pageCount,
		"totalCount" ~~> totalCount,
		])
	}

}
