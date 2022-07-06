//
//  CheckoutInfoVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 29/06/22.
//

import UIKit

class CheckoutInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func Nextstep_Tapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CheckoutInfoVC2") as! CheckoutInfoVC2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
