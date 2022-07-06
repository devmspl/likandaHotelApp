//
//  LoginVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit
import Alamofire
import AuthenticationServices

class LoginVC: UIViewController {
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBAction func signInTapped(_sender: Any){
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName,.email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "id") != nil{
            let vc = storyBoards.Bottombar.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // Do any additional setup after loading the view.
    }
       
    @IBAction func creatAccount_tapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func continue_tapped(_ sender: Any) {
        
        if EmailField.text == "" && PasswordField.text == ""{
            let alert3 = UIAlertController(title: "Login", message: "Please enter username & password", preferredStyle: .alert)
            let ok3 = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert3.addAction(ok3)
            self.present(alert3, animated: true, completion: nil)
        }
        
        else if EmailField.text == ""{
            let alert = UIAlertController(title: "Login", message: "Please enter email", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        else if PasswordField.text == ""{
            let alert2 = UIAlertController(title: "Login", message: "Please enter password", preferredStyle: .alert)
            let ok2 = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert2.addAction(ok2)
            self.present(alert2, animated: true, completion: nil)
        }else{
            loginApi()
        }
        
        
        
    }
    
    @IBAction func forgotPass_tapped(_ sender: Any) {
        let vc = storyBoards.Main.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    }

extension LoginVC{
    func loginApi(){
        let para:[String:Any] = [
            "email":EmailField.text!,
            "password":PasswordField.text!,
            "deviceToken":"Hotel"
        ]
        print(para)
        
        AF.request(Api.Login,method: .post,parameters: para,encoding: JSONEncoding.default).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    print("api integrated")
                    let data = respond.object(forKey: "data") as! NSDictionary
                    let id = data.object(forKey: "id") as! String
                    let token = data.object(forKey: "token") as! String
                    UserDefaults.standard.setValue(id, forKey: "id")
                    UserDefaults.standard.setValue(token, forKey: "token")
                    let vc = storyBoards.Bottombar.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let message = respond.object(forKey: "error") as! String
                    let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    print("ksdbviu")
                }
            }
            case .failure(let error): do{
                print(error)
            }
            
            }
        }
    }
}

extension UIViewController: ASAuthorizationControllerDelegate {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential{
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("user id is \(userIdentifier)\n Full Name is \(String(describing: fullName)) \n Email id \(String(describing: email))")
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
