//
//  Post.swift
//  CurrencySwap
//
//  Created by Admin on 2019-07-03.
//  Copyright © 2019 Test. All rights reserved.
//

//import UIKit
//
//class Post: NSObject {
//
//}

import Foundation
import Firebase

struct Post: Decodable{
    
    var email: String?
    var location: String?
    var myAmount: String?
    var myCurrency: String?
    var radius: String?
    var yourAmount: String?
    var yourCurrency: String?
    
    init(dictionary: [String: AnyObject]){
        self.location = dictionary["Location"] as? String
        self.myAmount = dictionary["myAmount"] as? String
        self.myCurrency = dictionary["myCurrency"] as? String
        self.radius = dictionary["radius"] as? String
        self.yourAmount = dictionary["yourAmount"] as? String
        self.yourCurrency = dictionary["yourCurrency"] as? String
    }
    
    
//    init(email: String, location: String, myAmount: Int, myCurrency: String, radius: Int, yourAmount: Int, yourCurrency: String) {
//        self.email = email
//        self.location = location
//        self.myAmount = myAmount
//        self.myCurrency = myCurrency
//        self.radius = radius
//        self.yourAmount = yourAmount
//        self.yourCurrency = yourCurrency
//    }
//    init?(snapshot: DataSnapshot) {
//        guard
//            var value = snapshot.value as? [String: AnyObject],
//            let location = value["location"] as? String,
//            let myAmount = value["myAmount"] as? Int,
//            let myCurrency = value["myCurrency"] as? String,
//            let radius = value["radius"] as? Int,
//            let yourAmount = value["yourAmount"] as? Int,
//            let yourCurrency = value["yourCurrency"] as? String
//            else {
//                return nil
//        }
//        self.email = "w"
//        self.location = location
//        self.myAmount = myAmount
//        self.myCurrency = myCurrency
//        self.radius = radius
//        self.yourAmount = yourAmount
//        self.yourCurrency = yourCurrency
//    }
}
