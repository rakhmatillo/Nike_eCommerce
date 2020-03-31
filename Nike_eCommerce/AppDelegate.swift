//
//  AppDelegate.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 2/28/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        if UserDefaults.standard.bool(forKey: K.IS_LOGGED) {
            let vc = MainVC(nibName: "MainVC", bundle: nil)

            window?.rootViewController = UINavigationController(rootViewController: vc)
        }else{
            let vc = WelcomeVC(nibName: "WelcomeVC", bundle: nil)
            window?.rootViewController = UINavigationController(rootViewController: vc)
            
           

        }
      
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        FirebaseApp.configure()
        _ = Firestore.firestore()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let e = error{
                print("Firebase error: \(e)")
                return
            }
            print("User signed with firebase")
            UserDefaults.standard.set(true, forKey: K.IS_LOGGED)
            self.window?.rootViewController = UINavigationController(rootViewController:MainVC(nibName: "MainVC", bundle: nil))
            
            
        }
        
    }
    
}

