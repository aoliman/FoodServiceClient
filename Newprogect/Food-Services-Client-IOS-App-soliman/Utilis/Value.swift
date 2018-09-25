//
//  Value.swift
//  FoodService
//
//  Created by index-ios on 3/26/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import Foundation
import Moya
let CardId="CardId"
let OwnerId="OwnerId"
let MapKey="AIzaSyDsz2tucW-OMpD4duveaEgZLHAGBRuJkeY"
let Card = "Card"
let Clientid = 300
let Type = "Type"
let HomeCookerId = "HomeCookerId"
let PartyCookerId = "PartyCookerId"
let Profileid = "Profileid"
let Profiletype = "Profiletype"
let UserId = "UserId"
let UserAuthKey = "UserAuthKey"
var cancellabelArry:[Cancellable]=[]
let ShowMore = "ShowMore"
let Google_Location_key = "AIzaSyD519L1cFwnw2AJTDNOHC3Nnf1WVlcyexo"
func CancelAllrequsst(){
    cancellabelArry.forEach { cancellable in cancellable.cancel() }
    // here I go through the array and cancell each request.
    //Load View Hide
    cancellabelArry.removeAll()
}
let colorPending = #colorLiteral(red: 0.8431372549, green: 0.8235294118, blue: 0.3215686275, alpha: 1)
let colorAccepted = #colorLiteral(red: 0.4392156863, green: 0.8352941176, blue: 0.3764705882, alpha: 1)
let colorRefused = #colorLiteral(red: 0.8235294118, green: 0.2235294118, blue: 0.2901960784, alpha: 1)
let colorFinished = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.3764705882, alpha: 1)
let colorDelivered = #colorLiteral(red: 0.2196078431, green: 0.4235294118, blue: 0.231372549, alpha: 1)
let colorTaken = #colorLiteral(red: 0.09676349908, green: 0.5636769533, blue: 0.9247723222, alpha: 1)
let colorOnTheWay = #colorLiteral(red: 0.9137254902, green: 0.4980392157, blue: 0.2705882353, alpha: 1)
let colorArrived = #colorLiteral(red: 0.05098039216, green: 0.631372549, blue: 0.1450980392, alpha: 1)

 let raduis = 100000000000



