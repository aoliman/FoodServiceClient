//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct FoodCarCatogary: Glossy {

	public let data : [FoodcarcatogaryData]!



	//MARK: Decodable
	public init?(json: JSON){
		data = "data" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"data" ~~> data,
		])
	}

}
