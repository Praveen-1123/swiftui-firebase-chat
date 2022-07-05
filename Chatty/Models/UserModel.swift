//
//  UserModel.swift
//  Chatty
//
//  Created by Praveen Murugan on 03/11/21.
//

struct User {
    var uid: String
    var email: String?
    
    static let `default` = Self(
        uid: "sdfdsaf",
        email: "ben.mcmahen@gmail.com"
    )

    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
