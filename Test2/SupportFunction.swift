//
//  SupportFunction.swift
//  Test2
//
//  Created by Rheza Pahlevi on 12/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit

class SupportFunction: NSObject {
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "dd/MM/yyyy"
         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd/MM/yyyy"
         let newDate = convertDateFormatter.date(from: inputDate)
         return convertDateFormatter.string(from: newDate!)
        
    }
}
