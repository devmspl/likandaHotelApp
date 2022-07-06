//
//  CheckoutInfoVC2.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 29/06/22.
//

import UIKit

class CheckoutInfoVC2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func Nextstep_Tapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CongratulationsVC") as! CongratulationsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
