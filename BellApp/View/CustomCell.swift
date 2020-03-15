//
//  CustomCell.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/11.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var bell1TimeLabel: UILabel!
    @IBOutlet weak var bell2TimeLabel: UILabel!
    @IBOutlet weak var bell3TimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
