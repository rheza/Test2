//
//  ActivityAInfoCell.swift
//  Test2
//
//  Created by Rheza Pahlevi on 13/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit

class ActivityAInfoCell: UITableViewCell {

    @IBOutlet weak var productCodeField: UITextField!
    
    @IBOutlet weak var activityTypeField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeStart: UITextField!
    
    @IBOutlet weak var timeStop: UITextField!
    
    @IBOutlet weak var planToStartDate: UITextField!
    
    
    @IBOutlet weak var reasonTextField: UITextView!
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
