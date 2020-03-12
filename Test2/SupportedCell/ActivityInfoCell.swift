//
//  ActivityInfoCell.swift
//  Test2
//
//  Created by Rheza Pahlevi on 12/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit

class ActivityInfoCell: UITableViewCell {

    @IBOutlet weak var activityTypeField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeStart: UITextField!
    @IBOutlet weak var timeStop: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
