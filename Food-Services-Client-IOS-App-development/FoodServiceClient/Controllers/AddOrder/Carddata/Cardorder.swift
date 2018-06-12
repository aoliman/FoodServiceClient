//
//	RootClass.swift
//
//	Create by index-ios on 28/3/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Cardorder : NSObject, NSCoding{

	var client : Int!
	var clientDeliveryType : String!
	var cookerDeliveryType : String!
	var deliveryDate : Int!
	var deliveryPlace : Int!
	var ownedid : Int!
	var productOrders : [CardProductOrder]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		client = dictionary["client"] as? Int
		clientDeliveryType = dictionary["clientDeliveryType"] as? String
		cookerDeliveryType = dictionary["cookerDeliveryType"] as? String
		deliveryDate = dictionary["deliveryDate"] as? Int
		deliveryPlace = dictionary["deliveryPlace"] as? Int
		ownedid = dictionary["ownedid"] as? Int
		productOrders = [CardProductOrder]()
        
		if let productOrdersArray = dictionary["productOrders"] as? [[String:Any]]{
			for dic in productOrdersArray{
				let value = CardProductOrder(fromDictionary: dic)
				productOrders.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if client != nil{
			dictionary["client"] = client
		}
		if clientDeliveryType != nil{
			dictionary["clientDeliveryType"] = clientDeliveryType
		}
		if cookerDeliveryType != nil{
			dictionary["cookerDeliveryType"] = cookerDeliveryType
		}
		if deliveryDate != nil{
			dictionary["deliveryDate"] = deliveryDate
		}
		if deliveryPlace != nil{
			dictionary["deliveryPlace"] = deliveryPlace
		}
		if ownedid != nil{
			dictionary["ownedid"] = ownedid
		}
		if productOrders != nil{
			var dictionaryElements = [[String:Any]]()
			for productOrdersElement in productOrders {
				dictionaryElements.append(productOrdersElement.toDictionary())
			}
			dictionary["productOrders"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         client = aDecoder.decodeObject(forKey: "client") as? Int
         clientDeliveryType = aDecoder.decodeObject(forKey: "clientDeliveryType") as? String
         cookerDeliveryType = aDecoder.decodeObject(forKey: "cookerDeliveryType") as? String
         deliveryDate = aDecoder.decodeObject(forKey: "deliveryDate") as? Int
         deliveryPlace = aDecoder.decodeObject(forKey: "deliveryPlace") as? Int
         ownedid = aDecoder.decodeObject(forKey: "ownedid") as? Int
         productOrders = aDecoder.decodeObject(forKey :"productOrders") as? [CardProductOrder]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if client != nil{
			aCoder.encode(client, forKey: "client")
		}
		if clientDeliveryType != nil{
			aCoder.encode(clientDeliveryType, forKey: "clientDeliveryType")
		}
		if cookerDeliveryType != nil{
			aCoder.encode(cookerDeliveryType, forKey: "cookerDeliveryType")
		}
		if deliveryDate != nil{
			aCoder.encode(deliveryDate, forKey: "deliveryDate")
		}
		if deliveryPlace != nil{
			aCoder.encode(deliveryPlace, forKey: "deliveryPlace")
		}
		if ownedid != nil{
			aCoder.encode(ownedid, forKey: "ownedid")
		}
		if productOrders != nil{
			aCoder.encode(productOrders, forKey: "productOrders")
		}

	}

}
