//
//  TabbarVC.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit

class TabbarVC: UITabBarController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tabBarController?.tabBar.roundCorners([.topLeft,.topRight], radius: 20)
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
