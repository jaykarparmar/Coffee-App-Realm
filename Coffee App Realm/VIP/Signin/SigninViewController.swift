//
//  SigninViewController.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import UIKit
import FBSDKLoginKit

class SigninViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func actionFacebook(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if error != nil {
                self.showPopup(message: "Logged In Successfully")
//              self.showPopup(isSuccess: false, type: .facebook)
                return
            }
            guard let token = AccessToken.current else {
                print("Failed to get access token")
                self.showPopup(message: "Something went wrong")
                return
            }
        }
    }
    
}

extension UIViewController {
    func showPopup(message: String) {
      let alert = UIAlertController(title: "Coffee App", message: message, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
}
