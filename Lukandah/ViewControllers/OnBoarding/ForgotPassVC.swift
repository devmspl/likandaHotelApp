//
//  ForgotPassVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit

class ForgotPassVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func continue_tapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
