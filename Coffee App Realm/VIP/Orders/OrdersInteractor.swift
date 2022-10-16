//
//  OrdersInteractor.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation
import RealmSwift

protocol OrdersInteractorProtocol {
    func getOrdersFromRealm() -> [CoffeeOrder]
}

class OrdersInteractor: OrdersInteractorProtocol {
    
    var presenter: OrdersPresenterProtocol?
    private let realm = try! Realm()
    
    func getOrdersFromRealm() -> [CoffeeOrder] {
        return realm.objects(CoffeeOrder.self).map({$0})
    }
    
}
