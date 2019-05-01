//
//  TaskCell.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/3/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

// change button protocol - called in ChecklistViewController. changes boolean value of a task / appends it to a checks array
protocol ChangeButton {
    func changeButton(checked: Bool, index: Int?)
}

class TaskCell: UITableViewCell {
    
    // variables
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        // giving information from cell that shows if the checkbox image can be changed or not
        if tasks![indexP!].checked {
            delegate?.changeButton(checked: false, index: indexP!)
        } else {
            delegate?.changeButton(checked: true, index: indexP!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var delegate: ChangeButton?
    var indexP: Int?
    var tasks: [Task]?
    
}
