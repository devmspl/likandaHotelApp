//
//  SettingVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 14/05/22.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var hotelId: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileIg: UIImageView!
    @IBOutlet weak var settingTable: UITableView!
  ///
    @IBOutlet weak var Topview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellLoad()
        settingTable.dataSource = self
        settingTable.delegate = self
        self.Topview.layer.cornerRadius = 25
        Topview.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }
///
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

   
    func cellLoad(){
        settingTable.register(UINib.init(nibName: "ProfileTableCell", bundle: nil), forCellReuseIdentifier: "ProfileTableCell")
    }
    @IBAction func onBackTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onNotificationTap(_ sender: Any) {
    }
    @IBAction func onSideMenuTap(_ sender: Any) {
    }
    
}

extension SettingVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: "ProfileTableCell", for: indexPath) as! ProfileTableCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
