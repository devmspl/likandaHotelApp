//
//  FilterSheetVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 21/05/22.
//

import UIKit
import Alamofire

class FilterSheetVC: UIViewController {
    @IBOutlet weak var Ratings: UIView!
    @IBOutlet weak var Pricerange: UIView!
    @IBOutlet weak var Distancefromaddress: UIView!
    @IBOutlet weak var Paymentmode: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func Showresult_Tapped(_ sender: Any) {
        getbyfilter()
    }
    
}


extension FilterSheetVC{
    func getbyfilter(){
//        rating=5&priceFrom=f&priceTo=vghv&paymentMode=gg&isFreeCancellation=hg&isMealAvailable=vhv&isParkingAvailable=hgv&isPetAllow=hv&lat=hv&long=hgv&distance=gvgh
        if ReachabilityNetwork.isConnectedToNetwork(){
            let queryString = "rating=\(Ratings)&priceFrom=\(10)&priceTo=\(500)&paymentMode=\(Paymentmode)&FreeCancellation=\(true)&isMealAvailable=\(true)&isParkingAvailable=\(true)&isPetAllow=\(true)&lat=\(10.00)&long=\(20.20)&distance=\(Distancefromaddress)"
            AF.request(Api.Hotelsbyfilter+queryString,method: .get).responseJSON{
                response in
                switch(response.result){
                case.success(let json):do{
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    print(respond)
                    if status == 200{
                }
                }
                case .failure(let error):do{
                    print(error)
                }
            }
          }
        }else{
        
        }
        }
        
       
}
