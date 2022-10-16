//
//  SigninViewController.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import UIKit
import FBSDKLoginKit
import RealmSwift

class SigninViewController: UIViewController {

    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = UIButton(type: .custom)
                loginButton.backgroundColor = .darkGray
                loginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
                loginButton.center = view.center
                loginButton.setTitle("My Login Button", for: .normal)

                // Handle clicks on the button
                loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)

                view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    
    @objc func loginButtonClick() {
            let loginManager = LoginManager()
            loginManager.logIn(permissions: ["public_profile", "email"], from: self) { result, error in
                if let error = error {
                    print("Encountered Erorr: \(error)")
                } else if let result = result, result.isCancelled {
                    print("Cancelled")
                } else {
                    print("Logged In")
                    self.getFBUserDetail(VC: self, token: result?.token?.tokenString ?? "") { user, error in
                        self.saveUserToRealm(user: user)
                    }
                }
            }
        }
    
    func getFBUserDetail(VC: UIViewController, token: String, completion: @escaping (_ user: SocialUser?,  _ error: String?)-> Void){
        let parameters = ["fields" : "email, name, first_name, last_name, picture.type(large)"]
        GraphRequest(graphPath: "me", parameters: parameters).start { (connection, conresult, error) in
            if let Err = error{
                completion(nil, Err.localizedDescription)
            }else{
                if let result = conresult, let dataDic = result as? [String: Any]{
                    let obj = SocialUser()
                    obj.socialType = "facebook"
                    obj.userId = dataDic["id"] as? String ?? ""
                    obj.token = token
                    obj.firstName = dataDic["first_name"] as? String ?? ""
                    obj.lastName = dataDic["last_name"] as? String ?? ""
                    obj.email = dataDic["email"] as? String ?? ""
                    let profileUrl = "https://graph.facebook.com/\(obj.userId ?? "")/picture?type=large"
                    
                    obj.profile = profileUrl
                    
                    completion(obj, nil)
                }
            }
        }
    }
    
    func saveUserToRealm(user: SocialUser?) {
        realm.beginWrite()
        let fbUser = FBUser()
        fbUser.token = user?.token
        fbUser.userName = user?.firstName
        fbUser.email = user?.email
        realm.add(fbUser)
        try! realm.commitWrite()
    }
}

extension UIViewController {
    func showPopup(message: String) {
      let alert = UIAlertController(title: "Coffee App", message: message, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
}
