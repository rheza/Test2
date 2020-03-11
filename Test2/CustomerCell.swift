//
//  CustomerCell.swift
//  Test2
//
//  Created by Rheza Pahlevi on 11/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var birthdayDate: UILabel!
    @IBOutlet weak var updatedDate: UILabel!
    @IBOutlet weak var productName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
