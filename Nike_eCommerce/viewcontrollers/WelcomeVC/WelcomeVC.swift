//
//  WelcomeVC.swift
//  Nike_eCommerce
//
//  Created by Rakhmatillo Topiboldiev on 2/28/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
//import FacebookLogin
//import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
class WelcomeVC: UIViewController, LoginButtonDelegate{
    
    
    
    @IBOutlet weak var signUpBackView: UIView!
    @IBOutlet weak var signUpLineView: UIView!
    @IBOutlet weak var signUpLbl: UILabel!
    
    @IBOutlet weak var loginBackView: UIView!
    @IBOutlet weak var loginLineView: UIView!
    @IBOutlet weak var loginLbl: UILabel!
    
    @IBOutlet weak var userNameBackView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    
    @IBOutlet weak var facebookLoginBtn: FBLoginButton!
    
    
    
    var isUserSigned = false
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    //MARK: - Setup UI
    func setupUI(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        facebookLoginBtn.delegate = self
        
        if let accessToken = AccessToken.current{
            firebaseFacebookLogin(accessToken: accessToken.tokenString)
        }
        
        setLoginUI()
        setSignUpUI()
    }
    
    func setSignUpUI(){
        i = 0
        nextBtn.setTitle("SIGN UP", for: .normal)
        userNameBackView.isHidden = false
        
        loginBackView.backgroundColor = .clear
        loginLineView.isHidden = true
        loginLbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        loginLbl.textColor = .black
        
        signUpBackView.backgroundColor = UIColor(named: "backView")
        signUpLineView.isHidden = false
        signUpLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        signUpLbl.textColor = .black
        
    }
    
    func setLoginUI(){
       
        i = 1
        nextBtn.setTitle("LOGIN", for: .normal)
        userNameBackView.isHidden = true
        
        loginBackView.backgroundColor = UIColor(named: "backView")
        loginLineView.isHidden = false
        loginLbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        loginLbl.textColor = .black
        
        signUpBackView.backgroundColor = .clear
        signUpLineView.isHidden = true
        signUpLbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        signUpLbl.textColor = .black
    }
    
    //MARK: - Sign Up Button
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        setSignUpUI()
    }
    
    //MARK: - Login Button
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        setLoginUI()
    }
    
    
    
    //MARK: - Sign or login button
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        if i == 0{//signing page
            if let email = emailTextField.text, let password = passwordTextField.text{
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    if let e = error{
                        print(e)
                        print("*************")
                    }else{
                        UserDefaults.standard.set(true, forKey: K.IS_LOGGED)
                        let vc = MainVC(nibName: "MainVC", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }else{//login page
            if let email = emailTextField.text , let password = passwordTextField.text{
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    
                    if let _ = error{
                        let alert = UIAlertController(title: "Error in login", message: nil, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        UserDefaults.standard.set(true, forKey: K.IS_LOGGED)
                        let vc = MainVC(nibName: "MainVC", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }
            }
        }
    }
    
  
    
    
    
    //MARK: - Login with Facebook
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            return
        }
        
        if let accessToken = AccessToken.current?.tokenString{
            firebaseFacebookLogin(accessToken: accessToken)
        }
        let vc = MainVC(nibName: "MainVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //user logged out
        UserDefaults.standard.set(false, forKey: K.IS_LOGGED)
        
    }
    
    func firebaseFacebookLogin(accessToken: String){
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let _ = error{
                return
            }
            
            //User successfully signed in with facebook
            UserDefaults.standard.set(true, forKey: K.IS_LOGGED)
            let vc = MainVC(nibName: "MainVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    //MARK: - Terms and Condition
    @IBAction func termsAndCondition(_ sender: UIButton) {
        
    }
    
    
}
