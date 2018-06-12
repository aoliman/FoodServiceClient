//
//	ProductOrder.swift
//
//	Create by index-ios on 28/3/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CardProductOrder : NSObject, NSCoding{

	var count : Int!
	var product : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		count = dictionary["count"] as? Int
		product = dictionary["product"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if count != nil{
			dictionary["count"] = count
		}
		if product != nil{
			dictionary["product"] = product
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         count = aDecoder.decodeObject(forKey: "count") as? Int
         product = aDecoder.decodeObject(forKey: "product") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if count != nil{
			aCoder.encode(count, forKey: "count")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}

	}

}
