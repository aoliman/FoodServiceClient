//
//  addanotation.swift
//  pixel City
//
//  Created by index-ios on 2/27/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import MapKit
class addanotation: NSObject ,MKAnnotation {
    dynamic var coordinate : CLLocationCoordinate2D
    var identifier : String
    var title: String?
    init(coordinate : CLLocationCoordinate2D ,identifier : String, title :String){
     self.coordinate = coordinate
        self.identifier = identifier
        self.title=title
        super.init()
    }
    
   

}
