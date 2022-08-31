//
//  ForgotPassVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit
import Alamofire

class ForgotPassVC: UIViewController {
    @IBOutlet weak var Emailtext: UITextField!
    var data = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func continue_tapped(_ sender: Any) {
        otpApi()
    }
    
}

extension ForgotPassVC{
    func otpApi(){
        AF.request(Api.UserOTP+Emailtext.text!,method: .get).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    self.data = respond.object(forKey: "message") as! NSDictionary
                    let token = self.data.object(forKey: "otpToken") as! String
                    UserDefaults.standard.setValue(token, forKey: "token")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            case .failure(let error):do{
                print(error)
            }
            
    }
}
}
}
