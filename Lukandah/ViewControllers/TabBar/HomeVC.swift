//
//  HomeVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit
import Alamofire
import DropDown

class HomeVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var DateTF: UITextField!
    @IBOutlet weak var DateTF2: UITextField!
    @IBOutlet weak var GuestText: UITextField!
    @IBOutlet weak var RoomText: UITextField!
    
    var hotelData = [AnyObject]()
    var Drop = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gethotel()
        self.topView.layer.cornerRadius = 25
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner ]
        DateTF.delegate = self
        DateTF2.delegate = self
        GuestText.delegate = self
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == DateTF{
            datePicker(Textfi: DateTF)
        }else {
            datePicker(Textfi: DateTF2)
        }
        
    }
    @IBAction func guest_tapped(_ sender: Any) {
        Drop.show()
        Drop.dataSource = ["1 Guest","2 Guests","3 Guests","4 Guests"]
        Drop.anchorView = GuestText
        Drop.selectionAction = { [unowned self] (index: Int, item: String) in
            self.GuestText.text = item
                Drop.hide()
        }
    }
    
    @IBAction func room_tapped(_ sender: Any) {
        Drop.show()
        Drop.dataSource = ["1 Room","2 Rooms","3 Rooms","4 Rooms"]
        Drop.anchorView = RoomText
        Drop.selectionAction = { [unowned self]
            (Index: Int, item: String) in
            self.RoomText.text = item
            Drop.hide()
        }
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource , UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        cell.Hotelname.text = hotelData[indexPath.row]["name"] as! String
        cell.Charges.text = "\(hotelData[indexPath.row]["price"] as! Int)"
        cell.Reviews.text = hotelData[indexPath.row]["description"] as! String
        cell.Location.text = hotelData[indexPath.row]["discount"] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyBoards.Bottombar.instantiateViewController(withIdentifier: "HotelDetailsVC") as! HotelDetailsVC
        vc.hotelId = hotelData[indexPath.row]["id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.HotelCollectionname.text = hotelData[indexPath.row]["name"] as! String
        cell.Hotelcollectiondescription.text = hotelData[indexPath.row]["description"] as! String
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hc = storyboard?.instantiateViewController(withIdentifier: "HotelDetailsVC") as! HotelDetailsVC
        hc.hotelId = hotelData[indexPath.row]["id"] as! String
        self.navigationController?.pushViewController(hc, animated: true)
    }
    
}




class TableCell : UITableViewCell{
    @IBOutlet weak var Hotelimage: UIImageView!
    @IBOutlet weak var Hotelname: UILabel!
    @IBOutlet weak var Reviews: UILabel!
    @IBOutlet weak var Ratingimage: UIImageView!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Charges: UILabel!
    
}

class CollectionCell : UICollectionViewCell{
    @IBOutlet weak var Hotelcollectionimages: UIImageView!
    @IBOutlet weak var HotelCollectionname: UILabel!
    @IBOutlet weak var Hotelcollectiondescription: UILabel!
    
}

extension HomeVC{
    func gethotel(){
        AF.request(Api.Gethotel,method: .get).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    self.hotelData = respond.object(forKey: "data") as! [AnyObject]
                    self.tblView.reloadData()
                    self.searchCollectionView.reloadData()
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
}


extension HomeVC{
        
    func datePicker(Textfi: UITextField){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        Textfi.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancel,flexibleSpace,done], animated: true)
        Textfi.inputAccessoryView = toolbar
    }
    @objc func done(){
        DateTF.resignFirstResponder()
        DateTF2.resignFirstResponder()
        
        if let datepicker = DateTF.inputView as? UIDatePicker{
            datepicker.datePickerMode = .date
            let dateformatter  = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            DateTF.text = dateformatter.string(from: datepicker.date)
        }
        if  let datepicker = DateTF2.inputView as? UIDatePicker{
            datepicker.datePickerMode = .date
            let dateformatter  = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            DateTF2.text = dateformatter.string(from: datepicker.date)
        }
    }
    @objc func cancel(){
        DateTF.resignFirstResponder()
        DateTF2.resignFirstResponder()
    }
}
