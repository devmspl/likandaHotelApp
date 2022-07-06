//
//  HotelDetailsVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 17/05/22.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire

class HotelDetailsVC: UIViewController,MKMapViewDelegate {

    ///
    @IBOutlet weak var numberOfReviews: UILabel!
    @IBOutlet weak var stayDetail: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var checkOutTime: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    @IBOutlet weak var hotelDescription: UILabel!
    @IBOutlet weak var bath: UILabel!
    @IBOutlet weak var bathroom: UILabel!
    @IBOutlet weak var guestCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var hotelNamme: UILabel!
    @IBOutlet weak var hotelname: UILabel!
    ///
    @IBOutlet weak var mapVieew: MKMapView!
    @IBOutlet weak var starView: UIView!
    ///
    @IBOutlet weak var hotelImageCollection: UICollectionView!
    @IBOutlet weak var aminitiesCollection: UICollectionView!
    @IBOutlet weak var offerDetailsCollection: UICollectionView!
    
    var data = NSDictionary()
    ///
    ///
    var hotelId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gethotelbyid()

    }
    
    @IBAction func onReadPolicy(_ sender: Any) {
    }
    @IBAction func onCheckoutTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CheckoutInfoVC") as! CheckoutInfoVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onikeTap(_ sender: Any) {
    }
    
    @IBAction func onMessageTap(_ sender: Any) {
    }
    
    @IBAction func onShareTap(_ sender: Any) {
    }
    

}

extension HotelDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotelImageCollection{
            let cell = hotelImageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HotelImageCollCell
            return cell
        }else if collectionView == aminitiesCollection{
            let cell = aminitiesCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AminitiesCollectionCell
            return cell
        }else{
            let cell = offerDetailsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OfferCollCell
            return cell
        }
        
    }
    
    
}

extension HotelDetailsVC{
    func gethotelbyid(){
        AF.request(Api.Gethotelbyid+hotelId,method: .get).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    self.data = respond.object(forKey: "data") as! NSDictionary
                    self.setData()
                }else{
                    print("error")
                }
                
            }
            case .failure(let error):do{
                print(error)
            }
                
            }
        }
    }
    func setData(){
        hotelname.text = data.object(forKey: "name") as! String
        hotelNamme.text = data.object(forKey: "name") as! String
        hotelDescription.text = data.object(forKey: "description") as! String
        price.text = "$ \(data.object(forKey: "price")as! Int)"
    }
    
}
