//
//  FavoritesVC.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 13/06/22.
//

import UIKit

class FavoritesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var Maintableview: UITableView!{
        didSet{
            Maintableview.register(UINib(nibName: "FavoritesViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesViewCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesViewCell", for: indexPath) as? FavoritesViewCell else {return UITableViewCell()}
        return cell
    }
   

}
