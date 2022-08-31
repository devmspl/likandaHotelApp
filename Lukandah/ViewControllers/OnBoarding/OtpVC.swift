//
//  OtpVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit
import Alamofire

class OtpVC: UIViewController {
    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var second: UITextField!
    @IBOutlet weak var third: UITextField!
    @IBOutlet weak var fourth: UITextField!
    
    var data = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
     @IBAction func SubmitBtn(_ sender: Any) {
        otpverifyApi()
    }
}

extension OtpVC{
    func otpverifyApi(){
        let token = UserDefaults.standard.object(forKey: "token") as! String
        let para:[String:Any] = ["otp":"\(first.text!)\(second.text!)\(third.text!)\(fourth.text!)",
            "otpToken": token
        ]
        print("Helo",para)
        AF.request(Api.Otpverify,method: .post,parameters: para,encoding: JSONEncoding.default).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    self.data = respond.object(forKey: "message") as! NSDictionary
                    let vc = storyBoards.Main.instantiateViewController(withIdentifier: "ResetPassVC") as! ResetPassVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let message = respond.object(forKey: "error") as! String
                    let alert = UIAlertController(title: "Otp Verify", message: message, preferredStyle: .alert)
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
