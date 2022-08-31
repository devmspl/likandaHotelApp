//
//  ResetPassVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit
import Alamofire

class ResetPassVC: UIViewController {
    @IBOutlet weak var Emailtext: UITextField!
    @IBOutlet weak var Newpasswordtext: UITextField!
    @IBOutlet weak var Confirmpasswordtext: UITextField!
    
    var data = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    @IBAction func continue_tapped(_ sender: Any) {
        forgotpasswordApi()
    }
    
}

extension ResetPassVC{
    func forgotpasswordApi(){
        let token = UserDefaults.standard.object(forKey: "token") as! String
        let para:[String:Any] = [
            "email":Emailtext.text!,
            "newPassword":Newpasswordtext.text!,
            "otpToken":token
        ]
        print("FORGOTPASSWORD",para)
        AF.request(Api.Forgotpassword,method: .post,parameters: para,encoding: JSONEncoding.default).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    self.data = respond.object(forKey: "message") as! String
                    
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
