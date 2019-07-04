//
//  user.swift
//  CurrencySwap
//
//  Created by Admin on 2019-07-03.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    let uid: String
    let email: String
    
//    init(authData: Firebase.User) {
//        uid = authData.uid
//        email = authData.email!
//    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
