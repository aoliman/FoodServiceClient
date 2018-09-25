//
//  FirebaseUser.swift
//  FoodServiceProvider
//
//  Created by Index on 3/26/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Firebase

class UsersConversation {
    
    var conversationId: String = String()
    
    var unSeenCount: Int = Int()
    
    init(snap: DataSnapshot) {
        
        let userDict = snap.value as? [String: Any]

        self.unSeenCount = userDict?["unSeenCount"] as? Int != nil ? userDict?["unSeenCount"] as! Int : 0
        self.conversationId = userDict?["conversationId"] as? String != nil ? (userDict?["conversationId"] as? String)! : ""
        print(userDict)
    }
}
