//
//  OrdersPresenter.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation

protocol OrdersPresenterProtocol {
    func getOrdersFromRealm() -> [CoffeeOrder]
}

class OrdersPresenter: OrdersPresenterProtocol {
    
    weak var viewController: OrdersViewControllerProtocol?
    var interactor: OrdersInteractorProtocol?
    
    func getOrdersFromRealm() -> [CoffeeOrder] {
        return self.interactor?.getOrdersFromRealm() ?? []
    }
}
