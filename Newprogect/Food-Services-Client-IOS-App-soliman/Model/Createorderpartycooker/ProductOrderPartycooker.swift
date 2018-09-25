//
//	ProductOrder.swift
//
//	Create by index-ios on 11/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - ProductOrder
public struct ProductOrderPartycooker: Glossy {

	public let product : Product!



	//MARK: Decodable
	public init?(json: JSON){
		product = "product" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"product" ~~> product,
		])
	}

}
