//
//  OtpVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit

class OtpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submit_tapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPassVC") as! ResetPassVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
