//
//	RootClass.swift
//
//	Create by Patrick on 6/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HGSelectModel{

	var color : String!
	var degree : String!
	var mamory : String!
	var network : String!
	var shopImgPath : String!
	var shopPrice : Double!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		color = dictionary["color"] as? String
		degree = dictionary["degree"] as? String
		mamory = dictionary["mamory"] as? String
		network = dictionary["network"] as? String
		shopImgPath = dictionary["shopImgPath"] as? String
		shopPrice = dictionary["shopPrice"] as? Double
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if color != nil{
			dictionary["color"] = color
		}
		if degree != nil{
			dictionary["degree"] = degree
		}
		if mamory != nil{
			dictionary["mamory"] = mamory
		}
		if network != nil{
			dictionary["network"] = network
		}
		if shopImgPath != nil{
			dictionary["shopImgPath"] = shopImgPath
		}
		if shopPrice != nil{
			dictionary["shopPrice"] = shopPrice
		}
		return dictionary
	}

}
