//
//  Person.swift
//  DemoApp
//
//  Created by BridgeLabz on 24/05/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation

struct Contact {
    var contactId : Int
    var fullName : String
    var age : Int
    var email : String
    var mobileNumber : String
    
    func description () -> String{
        return ("""
            contactId -> \(contactId)
            Full Name -> \(fullName)
            Age -> \(age)
            Email -> \(email)
            Mobile Number -> \(mobileNumber)
            
        """)
    }
}
