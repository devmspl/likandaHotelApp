//
//  CongratulationsVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 29/06/22.
//

import UIKit

class CongratulationsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(timeInterval: TimeInterval(3.0), target: self, selector: #selector(timeExpired), userInfo: nil, repeats: false)
    }
       
    @objc func timeExpired(){
        let vc = storyBoards.Bottombar.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
