//
//  CoffeeOrder.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation
import RealmSwift

class CoffeeOrder: Object {
    @objc dynamic var uid: String? = ""
    @objc dynamic var coffeeType : String? = ""
    @objc dynamic var coffeeSize : String? = ""
}
