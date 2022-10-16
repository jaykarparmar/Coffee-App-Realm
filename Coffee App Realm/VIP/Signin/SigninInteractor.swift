//
//  SigninInteractor.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import Foundation
import RealmSwift

protocol SigninInteractorProtocol {
    func saveUserToRealm(user: SocialUser?, completion: @escaping () -> Void)
}

class SigninInteractor: SigninInteractorProtocol {
    var presenter: SigninPresenterProtocol?
    private let realm = try! Realm()
    
    func saveUserToRealm(user: SocialUser?, completion: @escaping () -> Void) {
        realm.beginWrite()
        let fbUser = FBUser()
        fbUser.token = user?.token
        fbUser.userName = user?.firstName
        fbUser.email = user?.email
        realm.add(fbUser)
        try! realm.commitWrite()
        completion()
    }
}
