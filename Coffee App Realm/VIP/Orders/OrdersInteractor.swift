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
    func deleteOrder(order: CoffeeOrder, completion: @escaping () -> Void)
    func removeRealm(completion: @escaping () -> Void)
}

class OrdersInteractor: OrdersInteractorProtocol {
    
    var presenter: OrdersPresenterProtocol?
    private let realm = try! Realm()
    
    func getOrdersFromRealm() -> [CoffeeOrder] {
        return realm.objects(CoffeeOrder.self).map({$0})
    }
    
    func deleteOrder(order: CoffeeOrder, completion: @escaping () -> Void) {
        realm.beginWrite()
        realm.delete(order)
        try! realm.commitWrite()
        completion()
    }
    
    func removeRealm(completion: @escaping () -> Void) {
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
        completion()
    }
}
