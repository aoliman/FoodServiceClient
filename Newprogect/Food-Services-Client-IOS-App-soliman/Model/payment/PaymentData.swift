//
//	RootClass.swift
//
//	Create by Index on 21/6/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation 
import Gloss

//MARK: - RootClass
public struct PaymentData: Glossy {

	public let addressCity : AnyObject!
	public let addressCountry : AnyObject!
	public let addressLine1 : AnyObject!
	public let addressLine1Check : AnyObject!
	public let addressLine2 : AnyObject!
	public let addressState : AnyObject!
	public let addressZip : AnyObject!
	public let addressZipCheck : AnyObject!
	public let brand : String!
	public let country : String!
	public let customer : String!
	public let cvcCheck : String!
	public let dynamicLast4 : AnyObject!
	public let expMonth : Int!
	public let expYear : Int!
	public let fingerprint : String!
	public let funding : String!
	public let id : String!
	public let last4 : String!
	public let metadata : Metadata!
	public let name : AnyObject!
	public let object : String!
	public let tokenizationMethod : AnyObject!



	//MARK: Decodable
	public init?(json: JSON){
		addressCity = "address_city" <~~ json
		addressCountry = "address_country" <~~ json
		addressLine1 = "address_line1" <~~ json
		addressLine1Check = "address_line1_check" <~~ json
		addressLine2 = "address_line2" <~~ json
		addressState = "address_state" <~~ json
		addressZip = "address_zip" <~~ json
		addressZipCheck = "address_zip_check" <~~ json
		brand = "brand" <~~ json
		country = "country" <~~ json
		customer = "customer" <~~ json
		cvcCheck = "cvc_check" <~~ json
		dynamicLast4 = "dynamic_last4" <~~ json
		expMonth = "exp_month" <~~ json
		expYear = "exp_year" <~~ json
		fingerprint = "fingerprint" <~~ json
		funding = "funding" <~~ json
		id = "id" <~~ json
		last4 = "last4" <~~ json
		metadata = "metadata" <~~ json
		name = "name" <~~ json
		object = "object" <~~ json
		tokenizationMethod = "tokenization_method" <~~ json
	}


	//MARK: Encodable
	public func toJSON() -> JSON? {
		return jsonify([
		"address_city" ~~> addressCity,
		"address_country" ~~> addressCountry,
		"address_line1" ~~> addressLine1,
		"address_line1_check" ~~> addressLine1Check,
		"address_line2" ~~> addressLine2,
		"address_state" ~~> addressState,
		"address_zip" ~~> addressZip,
		"address_zip_check" ~~> addressZipCheck,
		"brand" ~~> brand,
		"country" ~~> country,
		"customer" ~~> customer,
		"cvc_check" ~~> cvcCheck,
		"dynamic_last4" ~~> dynamicLast4,
		"exp_month" ~~> expMonth,
		"exp_year" ~~> expYear,
		"fingerprint" ~~> fingerprint,
		"funding" ~~> funding,
		"id" ~~> id,
		"last4" ~~> last4,
		"metadata" ~~> metadata,
		"name" ~~> name,
		"object" ~~> object,
		"tokenization_method" ~~> tokenizationMethod,
		])
	}

}
