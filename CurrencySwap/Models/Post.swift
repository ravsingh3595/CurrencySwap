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

struct Post {
    
//    let ref: DatabaseReference?
    var email: String
    var location: String
    var myAmount: Int
    var myCurrency: String
    var radius: Int
    var yourAmount: Int
    var yourCurrency: String
    
    init(email: String, location: String, myAmount: Int, myCurrency: String, radius: Int, yourAmount: Int, yourCurrency: String) {
//        self.ref = nil
        self.email = email
        self.location = location
        self.myAmount = myAmount
        self.myCurrency = myCurrency
        self.radius = radius
        self.yourAmount = yourAmount
        self.yourCurrency = yourCurrency
    }
    init?(snapshot: DataSnapshot) {
        guard
            var value = snapshot.value as? [String: AnyObject],
            let location = value["location"] as? String,
            let myAmount = value["myAmount"] as? Int,
            let myCurrency = value["myCurrency"] as? String,
            let radius = value["radius"] as? Int,
            let yourAmount = value["yourAmount"] as? Int,
            let yourCurrency = value["yourCurrency"] as? String
            else {
                return nil
        }
//        self.ref = nil
        self.email = "w"
        self.location = location
        self.myAmount = myAmount
        self.myCurrency = myCurrency
        self.radius = radius
        self.yourAmount = yourAmount
        self.yourCurrency = yourCurrency
    }
}
