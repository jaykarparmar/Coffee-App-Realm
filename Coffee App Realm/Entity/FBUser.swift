//
//  FBUser.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation
import RealmSwift

class FBUser: Object {
    @objc dynamic var token: String? = ""
    @objc dynamic var userName : String? = ""
    @objc dynamic var email : String? = ""
}

class SocialUser: Codable{
    var userId : String?
    var token : String?
    var firstName : String?
    var lastName : String?
    var email : String? = nil
    var profile : String?
    var socialType : String?
}
