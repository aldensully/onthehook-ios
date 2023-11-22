//
//  UserManager.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/21/23.
//

import Foundation

struct User:Identifiable,Codable{
    let id:String
    let username:String
    let creation_date:String
}

extension User {
    static var TEST_USER = User(id:"123",username:"Rainbowkitty",creation_date:"2023-11-20")
}
