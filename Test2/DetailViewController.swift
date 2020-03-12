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
        let context = self.fetchedResultsController.managedObjectContext
        let customer = Customer(context: context)
             
        // If appropriate, configure the new managed object.
        
        customer.name = detailItem?.name
        customer.birthday = detailItem?.birthday
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
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
       // MARK: - Fetched results controller
    
     var fetchedResultsController: NSFetchedResultsController<Customer> {
            if _fetchedResultsController != nil {
                return _fetchedResultsController!
            }
            
            let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest()
            
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 20
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Edit the section name key path and cache name if appropriate.
            // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
            aFetchedResultsController.delegate = self
            _fetchedResultsController = aFetchedResultsController
            
            do {
                try _fetchedResultsController!.performFetch()
            } catch {
                 // Replace this implementation with code to handle the error appropriately.
                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 let nserror = error as NSError
                 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            return _fetchedResultsController!
        }
        var _fetchedResultsController: NSFetchedResultsController<Customer>? = nil

        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.beginUpdates()
        }

        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
            switch type {
                case .insert:
                    tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
                case .delete:
                    tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
                default:
                    return
            }
        }

        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
                case .insert:
                    tableView.insertRows(at: [newIndexPath!], with: .fade)
                case .delete:
                    tableView.deleteRows(at: [indexPath!], with: .fade)
                case .update:
                    break
                   // configureCell(tableView.cellForRow(at: indexPath!) as! CustomerCell, withCustomer: anObject as! Customer)
                case .move:
                    break
                   // configureCell(tableView.cellForRow(at: indexPath!) as! CustomerCell, withCustomer: anObject as! Customer)
                    tableView.moveRow(at: indexPath!, to: newIndexPath!)
                default:
                    return
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.endUpdates()
        }

        /*
         // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
         
         func controllerDidChangeContent(controller: NSFetchedResultsController) {
             // In the simplest, most efficient, case, reload the table view.
             tableView.reloadData()
         }
         */

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


 

   
