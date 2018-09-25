//
//  FirebaseMessages.swift
//  FoodServiceProvider
//
//  Created by Index on 3/27/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Firebase

class FirebaseMessages {
    
    var createdAt: Date?
    var senderId: Int?
    var text: String?
    
    init(snap: DataSnapshot) {
        
        let conversition = snap.value as? [String: Any]
        
        print("doilklkl",conversition)
        
        let timeInterval = conversition?["createdAt"] as? Double
        if timeInterval != nil {
            self.createdAt = Date(timeIntervalSince1970: timeInterval! / 1000.0)
        } else {
            self.createdAt = nil
        }
        self.senderId = (conversition?["senderId"] as? Int) != nil ? (conversition?["senderId"] as? Int) : nil
        self.text = (conversition?["text"] as? String)  != nil ? (conversition?["text"] as? String) : nil
    }
    
}

