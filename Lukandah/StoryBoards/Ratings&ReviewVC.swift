//
//  Ratings&ReviewVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 29/06/22.
//

import UIKit
import Alamofire

class Ratings_ReviewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func WriteAReview_Tap(_ sender: Any) {
    }
    
    @IBAction func upcoming_tapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BookingsVC") as! BookingsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension Ratings_ReviewVC{
    func ratingreviewApi(){
        let userid = UserDefaults.standard.value(forKey: "id") as! String
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let head: HTTPHeaders = ["x-access-token": token]
        let para:[String:Any] = [
            "rating": "",
            "review": "",
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
                }
            }
            case .failure(let error):do{
                print(error)
            }
                
            }
        }
    }
}
