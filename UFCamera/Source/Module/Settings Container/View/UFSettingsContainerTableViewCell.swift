//
//  UFSettingsContainerTableViewCell.swift
//  UFCamera
//
//  Created by Kaustav Shee on 04/01/20.
//  Copyright © 2020 Kaustav Shee. All rights reserved.
//

import UIKit

class UFSettingsContainerTableViewCell: UITableViewCell {
    
    @IBOutlet var imageDisplay:UIImageView!
    @IBOutlet var consHeight:NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
