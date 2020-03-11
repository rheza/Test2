//
//  DetailViewController.swift
//  Test2
//
//  Created by Rheza Pahlevi on 11/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    

    @IBOutlet weak var tableView: UITableView!
    
   

    func configureView() {
        // Update the user interface for the detail item.
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Customer? {
        didSet {
            // Update the view.
            
            print(detailItem)
            
            
        }
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personalInfoCell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoCell", for: [0,1]) as! PersonalInfoCell
           
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        personalInfoCell.nameTextField.text = detailItem?.name

        personalInfoCell.birthdayTextfield.text = formatter.string(from: detailItem!.timestamp ?? Date())
        
        return personalInfoCell
    }

    func configurePersonalInfo(_ cell: PersonalInfoCell, withCustomer customer: Customer) {
        
      
      
     }
    
}

