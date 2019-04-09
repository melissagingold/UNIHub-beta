//
//  EssayListTableViewCell.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 4/8/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class EssayListTableViewCell: UITableViewCell {
    @IBOutlet weak var essayListName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
