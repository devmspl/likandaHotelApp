//
//  EditprofileVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 20/06/22.
//

import UIKit
import Alamofire
import DropDown

class EditprofileVC: UIViewController {
    @IBOutlet weak var Firstnamefield: UITextField!
    @IBOutlet weak var Genderoutlet: UILabel!
    @IBOutlet weak var Phonenumber: UITextField!
    @IBOutlet weak var Emailfield: UILabel!
    @IBOutlet weak var GenderLabel: UILabel!
    
    var Drop = DropDown()
    var data = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        getuserprofileapi()

       
    }
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        usersupdateapi()
        
    }
    
    @IBAction func Backtap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ChangePasswordTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func arrowdrop(_ sender: Any) {
        Drop.show()
        Drop.dataSource = ["Male","Female"]
        Drop.anchorView = GenderLabel
        Drop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.GenderLabel.text = item
            Drop.hide()
        }
    }
    
}

extension EditprofileVC{
    func usersupdateapi(){
        let userid = UserDefaults.standard.value(forKey: "id") as! String
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let head: HTTPHeaders = ["x-access-token": token]
        let para:[String:Any] = [
            "name":Firstnamefield.text!,
            "language":Genderoutlet.text!,
            "phoneNo":Phonenumber.text!,
            "deviceToken":"UsersUpdate"
        ]
        print(para,head)
        print(Api.Usersupdate+userid)
        AF.request(Api.Usersupdate+userid,method: .put,parameters: para,encoding: JSONEncoding.default,headers: head).responseJSON{
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

extension EditprofileVC{
    func getuserprofileapi(){
        let userid = UserDefaults.standard.value(forKey: "id") as! String
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let head: HTTPHeaders = ["x-access-token": token]
        print(Api.Getuserprofile+userid,"GET Profile")
        AF.request(Api.Getuserprofile+userid,method: .get,headers: head).responseJSON{
        response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                print(head)
                if status == 200{
                    self.data = respond.object(forKey: "data") as! NSDictionary
                    self.setdata()
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
    func setdata(){
        Firstnamefield.text = data.object(forKey: "name") as! String
//        Genderoutlet.text = data.object(forKey: "language") as! NSDictionary
        Phonenumber.text = " \(data.object(forKey: "phoneNo")as! String)"
       
    
    }
}
