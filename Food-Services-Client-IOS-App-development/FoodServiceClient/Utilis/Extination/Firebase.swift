//
//  Firebase.swift
//  FoodServiceProvider
//
//  Created by Index on 1/9/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://food-service-376f6.firebaseio.com/"
var chatRef: DatabaseReference = Database.database().reference(fromURL: "\(BASE_URL)/chat")
var userRef: DatabaseReference = Database.database().reference(fromURL: "\(BASE_URL)/users")
var conversationsRef: DatabaseReference = Database.database().reference(fromURL: "\(BASE_URL)/conversations") 
