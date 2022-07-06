//
//  FavoritesViewCell.swift
//  Lukandah
//
//  Created by Macbook Air (ios) on 13/06/22.
//

import UIKit

class FavoritesViewCell: UITableViewCell {
    @IBOutlet weak var Favimages: UIImageView!
    @IBOutlet weak var Hotelname: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Locationmarker: UIImageView!
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var Stars: UIImageView!
    @IBOutlet weak var Starscount: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Daysout: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
