//
//  AddUpdateOrdersPresenter.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation

protocol AddUpdateOrdersPresenterProtocol {
    func addOrder(order: CoffeeOrder, completion: @escaping () -> Void)
    func updateOrder(order: CoffeeOrder, completion: @escaping () -> Void)
}

class AddUpdateOrdersPresenter: AddUpdateOrdersPresenterProtocol {
    weak var viewController: AddUpdateOrdersViewControllerProtocol?
    var interactor: AddUpdateOrdersInteractorProtocol?
    
    func addOrder(order: CoffeeOrder, completion: @escaping () -> Void) {
        self.interactor?.addOrder(order: order, completion: {
            completion()
        })
    }
    
    func updateOrder(order: CoffeeOrder, completion: @escaping () -> Void) {
        self.interactor?.updateOrder(order: order, completion: {
            completion()
        })
    }
}
