//
//  SignUpVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit
import Alamofire

class SignUpVC: UIViewController {
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var FullnameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ConfirmpasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func Continue_Tapped(_ sender: Any) {
        if EmailField.text == "" && PasswordField.text == "" && FullnameField.text == ""{
            let alert3 = UIAlertController(title: "Signup", message: "Please fill all the fields", preferredStyle: .alert)
            let ok3 = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert3.addAction(ok3)
            self.present(alert3, animated: true, completion: nil)
            }
        else if EmailField.text == "" {
            let alert4 = UIAlertController(title: "Signup", message: "Please enter email", preferredStyle: .alert)
            let ok4 = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert4.addAction(ok4)
            self.present(alert4, animated: true, completion: nil)
    }
        else{
            signupApi()
    }
    }
    
}

extension SignUpVC{
    func signupApi(){
        let para:[String:Any] = [
            "email":EmailField.text!,
            "password":PasswordField.text!,
            "name":FullnameField.text!,
            "phoneNo":"8797",
            "deviceToken":"Hotel"
        ]
        print(para)
        
        AF.request(Api.Signup,method: .post,parameters: para,encoding: JSONEncoding.default).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    print("api integrated")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            case .failure(let error): do{
                print(error)
            }
            
            }
        }
    }

}
