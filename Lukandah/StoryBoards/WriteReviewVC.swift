//
//  WriteReviewVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 29/06/22.
//

import UIKit
import Alamofire

class WriteReviewVC: UIViewController {
    @IBOutlet weak var WritereviewText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func Confirm_Tapped(_ sender: Any) {
    }
    
}

extension WriteReviewVC{
    func reviewApi(){
        let userid = UserDefaults.standard.value(forKey: "id") as! String
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let head: HTTPHeaders = ["x-access-token": token]
        let para:[String:Any] = [
            "review": WritereviewText.text!,
            "rating": "",
            "customerName": ""
        ]
        AF.request(Api.RatingReviews+userid,method: .put,parameters: para,encoding: JSONEncoding.default,headers: head).responseJSON{
            response in
            switch(response.result){
            case.success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    print("API Integrated")
                    self.navigationController?.popViewController(animated: true)

                }
            }
            case .failure(let error):do{
                print(error)
            }
        }
    }
}
}
