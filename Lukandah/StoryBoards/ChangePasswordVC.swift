//
//  ChangePasswordVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 27/06/22.
//

import UIKit
import Alamofire

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var CurrentPasswordText: UITextField!
    @IBOutlet weak var NewPasswordText: UITextField!
    @IBOutlet weak var ConfirmPasswordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func ConfirmTapped(_ sender: Any) {
        resetpasswordApi()
    }
    @IBAction func Back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ChangePasswordVC{
    func resetpasswordApi(){
        let userid = UserDefaults.standard.value(forKey: "id") as! String
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let head : HTTPHeaders = ["x-access-token":token]
        let para:[String:Any] = [
            "oldPassword":CurrentPasswordText.text!,
            "newPassword":NewPasswordText.text!,
        ]
        print(para)
        
        AF.request(Api.ResetPassword+userid,method: .put,parameters: para,encoding: JSONEncoding.default,headers: head).responseJSON{
            response in
            switch(response.result){
            case.success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    print("API Integrated")
                    let alert2 = UIAlertController(title: "Login", message: "Password changed successfully.", preferredStyle: .alert)
                    let ok2 = UIAlertAction(title: "ok", style: .default) { ok in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert2.addAction(ok2)
                    self.present(alert2, animated: true, completion: nil)

                }else{ let message = respond.object(forKey: "error") as! String
                    let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    print("error")
                }
            }
            case .failure(let error):do{
                print(error)
            }
                
            }
        }
    }
}
