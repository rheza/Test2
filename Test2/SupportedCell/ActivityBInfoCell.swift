//
//  ActivityBInfoCell.swift
//  Test2
//
//  Created by Rheza Pahlevi on 13/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit

class ActivityBInfoCell: UITableViewCell {
    
    
    @IBOutlet weak var activityTypeField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeStart: UITextField!
    @IBOutlet weak var timeStop: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    @IBOutlet weak var planPriceField: UITextField!
    
    @IBOutlet weak var estimatedPlanField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
