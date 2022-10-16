//
//  SigninPresenter.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation

protocol SigninPresenterProtocol {
    func saveUserToRealm(user: SocialUser?, completion: @escaping () -> Void)
}

class SigninPresenter: SigninPresenterProtocol {
    
    weak var viewController: SigninViewController?
    var interactor: SigninInteractorProtocol?
    
    func saveUserToRealm(user: SocialUser?, completion: @escaping () -> Void) {
        self.interactor?.saveUserToRealm(user: user, completion: {
            completion()
        })
    }
}
