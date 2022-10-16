//
//  OrdersPresenter.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation

protocol OrdersPresenterProtocol {
    func getOrdersFromRealm() -> [CoffeeOrder]
    func deleteOrder(order: CoffeeOrder, completion: @escaping () -> Void)
}

class OrdersPresenter: OrdersPresenterProtocol {
    
    weak var viewController: OrdersViewControllerProtocol?
    var interactor: OrdersInteractorProtocol?
    
    func getOrdersFromRealm() -> [CoffeeOrder] {
        return self.interactor?.getOrdersFromRealm() ?? []
    }
    
    func deleteOrder(order: CoffeeOrder, completion: @escaping () -> Void) {
        self.interactor?.deleteOrder(order: order, completion: {
            completion()
        })
    }
}
