//
//  AppDelegate.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import UIKit
import FBSDKCoreKit
import RealmSwift

/*
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
*/
var user = FBUser()
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let realm = try! Realm()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if realm.objects(FBUser.self).map({$0}).count > 0 {
            user = realm.objects(FBUser.self).map({$0}).first as! FBUser
        }
        
        //        print(realm.objects(FBUser.self).map({$0}))
        
        if user.token == nil ||  user.token == "" {
            print("User Not Available")
            self.callLoginScreen()
        }
        else {
            print("User Available")
            self.callHomeScreen()
        }
        return true
    }
    
    func callHomeScreen() {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
        self.window!.rootViewController = navigationController
        UIView.transition(with: window!, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    func callLoginScreen() {
        let navigation:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let window = UIApplication.shared.delegate!.window!
        window!.rootViewController = navigation
        UIView.transition(with: window!, duration: 0.3, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }

}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
