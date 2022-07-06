//
//  ProfileVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 14/05/22.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    //MARK: - Outlets
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var appId: UILabel!
    @IBOutlet weak var proImageView: UIView!
    @IBOutlet weak var bookingCount: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var Profilepicture: UIImageView!
    
    @IBOutlet weak var Topview: UIView!
    @IBOutlet weak var Profilename: UILabel!
    let profileOptionArray = ["Edit Profile","Rewards & Wallet","Gift cards","Contact us","Settings","Sign out"]
    var data = NSDictionary()
    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        cellLoad()
        profileTable.dataSource = self
        profileTable.delegate = self
        self.Topview.layer.cornerRadius = 25
        Topview.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getprofile()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

   
    func cellLoad(){
        profileTable.register(UINib.init(nibName: "ProfileTableCell", bundle: nil), forCellReuseIdentifier: "ProfileTableCell")
    }
    @IBAction func onNotificationTap(_ sender: Any) {
    }
    @IBAction func onPencilTap(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
//        vc.sourceType = .camera
//        vc.sourceType = .savedPhotosAlbum
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    @IBAction func onNextTap(_ sender: Any) {
    }
    
    @IBAction func onSideMenuTap(_ sender: Any) {
    }
    
}

extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileOptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTable.dequeueReusableCell(withIdentifier: "ProfileTableCell") as! ProfileTableCell
        cell.titleLbl.text = profileOptionArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "EditprofileVC") as! EditprofileVC
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("hello")
        }
    }
}

extension ProfileVC{
    func getprofile(){
        let userid = UserDefaults.standard.value(forKey: "id") as! String
        let token = UserDefaults.standard.value(forKey: "token") as! String
        let head: HTTPHeaders = ["x-access-token": token]
        print(Api.Getprofile+userid,"Profile url")
        AF.request(Api.Getprofile+userid,method: .get,headers: head).responseJSON{
            response in
            switch(response.result){
            case .success(let json):do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
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
        Profilename.text = data.object(forKey: "name") as! String
        email.text = data.object(forKey: "email") as! String
        
    }
        
    }

extension ProfileVC{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            self.profileImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
