//
//  DetailViewController.swift
//  Test2
//
//  Created by Rheza Pahlevi on 11/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
   
    
    var managedObjectContext: NSManagedObjectContext? = nil
    @IBOutlet weak var tableView: UITableView!
    
    var sections: Array<String> = ["Section 1", "Section 2", "Section 3"]

    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    func configureView() {
        // Update the user interface for the detail item.
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 44.0;
       
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
    
    @IBAction func saveAction(_ sender: Any) {
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
       
        let entity =
          NSEntityDescription.entity(forEntityName: "Customer",
                                     in: managedContext)!
        
        let customer = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
       
        customer.setValue(detailItem?.name, forKeyPath: "name")
        
        
        do {
          try managedContext.save()
          
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let personalInfoCell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoCell", for: [0,1]) as! PersonalInfoCell
               
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            personalInfoCell.nameTextField.text = detailItem?.name

            personalInfoCell.birthdayTextfield.text = formatter.string(from: detailItem!.birthday ?? Date())
            
            
            return personalInfoCell
        } else if (indexPath.section == 1){
            let productSelectionCell = tableView.dequeueReusableCell(withIdentifier: "ProductSelectionCell", for: [1,1]) as! ProductSelectionCell
               
            productSelectionCell.productField.text = "Product B"
            
            return productSelectionCell
        } else if (indexPath.section == 2){
            let activityInfoCell = tableView.dequeueReusableCell(withIdentifier: "ActivityInfoCell", for: [2,1]) as! ActivityInfoCell
               
            activityInfoCell.activityTypeField.text = "Meeting"
            
            return activityInfoCell
        }
        
        return UITableViewCell()
        
    }

    func configurePersonalInfo(_ cell: PersonalInfoCell, withCustomer customer: Customer) {
        
      
      
     }
    
    
    func showDatePicker(forField field: UITextField, mode : String){
        print("show date picker")
        
        if (field.tag == 1){
            print("Date field called")
            datePicker.date = detailItem?.birthday ?? Date()
         
            
            datePicker.maximumDate = Date()
        }
        else if (field.tag == 2){
            datePicker.minimumDate = Date()
            
        }
        
        datePicker.datePickerMode = .date
        
        if (mode == "time"){
            datePicker.datePickerMode = .time
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        field.inputAccessoryView = toolbar
        field.inputView = datePicker
        
        
    }
    
    @objc func donedatePicker(){
 
        
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
     
    
     
}
    


extension DetailViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
              case 1:
                print("hello")
              case 2:
                print("hello2")
                showDatePicker(forField: textField, mode: "")
              default:
                print("break")
                break
              }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
          switch textField.tag {
                    case 1:
                        detailItem?.name = textField.text
                    case 2:
                        detailItem?.birthday = datePicker.date
                      print("hello2")
                    default:
                      print("break")
                      break
                    }
    }
    
}


 

   
