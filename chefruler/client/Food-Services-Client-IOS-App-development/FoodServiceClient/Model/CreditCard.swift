//
//	RootClass.swift
//
//	Create by index-ios on 3/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct CreditCard: Glossy {

	public let country : String!
	public let finishMonth : Int!
	public let finishYear : Int!
	public let nameInCard : String!
	public let number : String!
	public let postalCode : String!



	//MARK: Decodable
	public init?(json: JSON){
		country = "country" <~~ json
		finishMonth = "finishMonth" <~~ json
		finishYear = "finishYear" <~~ json
		nameInCard = "nameInCard" <~~ json
		number = "number" <~~ json
		postalCode = "postalCode" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"country" ~~> country,
		"finishMonth" ~~> finishMonth,
		"finishYear" ~~> finishYear,
		"nameInCard" ~~> nameInCard,
		"number" ~~> number,
		"postalCode" ~~> postalCode,
		])
	}

}
