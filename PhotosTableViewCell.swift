//
//  PhotosTableViewCell.swift
//  zynstagram
//
//  Created by Kenneth Pu on 9/16/15.
//  Copyright © 2015 Kenneth Pu. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var zymageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
