//
//  BookingsVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 06/07/22.
//

import UIKit

class BookingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func finished_tapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Ratings_ReviewVC") as! Ratings_ReviewVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    

}
