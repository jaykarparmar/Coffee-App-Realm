//
//  AddUpdateOrdersInteractor.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation
import RealmSwift

protocol AddUpdateOrdersInteractorProtocol {
    func addOrder(order: CoffeeOrder, completion: @escaping () -> Void)
    func updateOrder(order: CoffeeOrder, completion: @escaping () -> Void)
}

class AddUpdateOrdersInteractor: AddUpdateOrdersInteractorProtocol {
    
    var presenter: AddUpdateOrdersPresenterProtocol?
    private let realm = try! Realm()
    
    func addOrder(order: CoffeeOrder, completion: @escaping () -> Void) {
        realm.beginWrite()
        realm.add(order)
        try! realm.commitWrite()
        completion()
    }
    
    func updateOrder(order: CoffeeOrder, completion: @escaping () -> Void) {
        let updateContact = realm.objects(CoffeeOrder.self).filter("uid = %@",order.uid!)
        if let dataToBeUpdated = updateContact.first{

            try! realm.write {
                dataToBeUpdated.coffeeType = order.coffeeType
                dataToBeUpdated.coffeeSize = order.coffeeSize
                completion()
            }
        }
    }
}
