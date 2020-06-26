//
//  ImageCell.swift
//  Challenge4
//
//  Created by Stanislav Makhmoudov on 21.06.2020.
//  Copyright © 2020 GennadyMakhmudov. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var imageName: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
