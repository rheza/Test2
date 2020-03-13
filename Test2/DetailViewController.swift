//
//  DetailViewController.swift
//  Test2
//
//  Created by Rheza Pahlevi on 11/03/20.
//  Copyright © 2020 Rheza Pahlevi. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var sections: Array<String> = ["Section 1", "Section 2", "Section 3"]
    var products: Array<String> = ["General","Product A","Product B"]
    var activities: Array<String> = ["Meeting","Call", "Email"]
    let datePicker = UIDatePicker()
    
    
    
    var createMode: Bool = false
    var pickerMode: String = "Product"
    var currentPicker: Int = 0
    var customer: [NSManagedObject] = []
    
    
    var activeTextField = UITextField()
    
    
    func configureView() {
        // Update the user interface for the detail item.
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 44.0;
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if createMode {
            
            self.detailItem = {self.detailItem}()
            
            
            
        }
        configureView()
    }
    
    
    var detailItem: Customer? {
        
        didSet {
            if createMode {
                
                guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                        return
                }
                
                let customerEntity = NSEntityDescription.entity(forEntityName: "Customer", in: appDelegate.persistentContainer.viewContext)
                let newCustomer = Customer(entity: customerEntity!, insertInto: nil)
                detailItem = newCustomer
            } else {
                print("Called2")
                customer.append(detailItem!)
            }
            
            
        }
    }
    
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        if createMode {
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let idCustomer = Int.random(in: 1..<10000)
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            
            let entity = NSEntityDescription.entity(forEntityName: "Customer",  in: managedContext)!
            
            let customer = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
            
            customer.setValue(idCustomer, forKeyPath: "id")
            
            customer.setValue(detailItem?.birthday, forKeyPath: "birthday")
            customer.setValue(detailItem?.productType, forKeyPath: "productType")
            customer.setValue(detailItem?.name, forKeyPath: "name")
            customer.setValue(detailItem?.activityDate, forKey: "activityDate")
            customer.setValue(detailItem?.activityType, forKey: "activityType")
            customer.setValue(detailItem?.notes, forKey: "notes")
            customer.setValue(detailItem?.place, forKey: "place")
            customer.setValue(detailItem?.price, forKey: "price")
            customer.setValue(detailItem?.productCode, forKey: "productCode")
            customer.setValue(detailItem?.productType, forKey: "productType")
            customer.setValue(detailItem?.termPlan, forKey: "termPlan")
            customer.setValue(detailItem?.timeStart, forKey: "timeStart")
            customer.setValue(detailItem?.timeStop, forKey: "timeStop" )
            
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } else {
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let idCustomer = detailItem!.id
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Customer")
            fetchRequest.predicate = NSPredicate(format: "id = %@", idCustomer)
            
            
            do
            {
                let customerRetrieved = try managedContext.fetch(fetchRequest)
                
                let customer = customerRetrieved[0] as! NSManagedObject
                customer.setValue(detailItem?.birthday, forKeyPath: "birthday")
                customer.setValue(detailItem?.productType, forKeyPath: "productType")
                customer.setValue(detailItem?.name, forKeyPath: "name")
                customer.setValue(detailItem?.activityDate, forKey: "activityDate")
                customer.setValue(detailItem?.activityType, forKey: "activityType")
                customer.setValue(detailItem?.notes, forKey: "notes")
                customer.setValue(detailItem?.place, forKey: "place")
                customer.setValue(detailItem?.price, forKey: "price")
                customer.setValue(detailItem?.productCode, forKey: "productCode")
                customer.setValue(detailItem?.productType, forKey: "productType")
                customer.setValue(detailItem?.termPlan, forKey: "termPlan")
                customer.setValue(detailItem?.timeStart, forKey: "timeStart")
                customer.setValue(detailItem?.timeStop, forKey: "timeStop" )
                
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
            catch
            {
                print(error)
            }
            
            
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
            
            personalInfoCell.birthdayTextfield.text = formatter.string(from: detailItem?.birthday ?? Date())
            
            
            return personalInfoCell
        } else if (indexPath.section == 1){
            let productSelectionCell = tableView.dequeueReusableCell(withIdentifier: "ProductSelectionCell", for: [1,1]) as! ProductSelectionCell
            
            productSelectionCell.productField.text = detailItem?.productType
            
            return productSelectionCell
        } else if (indexPath.section == 2){
            
            if detailItem?.productType == "General" {
                let activityInfoCell = tableView.dequeueReusableCell(withIdentifier: "ActivityInfoCell", for: [2,1]) as! ActivityInfoCell
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                
                activityInfoCell.activityTypeField.text = detailItem?.activityType
                if (detailItem!.activityDate != nil){
                    
                    activityInfoCell.dateTextField.text = formatter.string(from: detailItem?.activityDate ?? Date())
                    
                }
                
                
                let formatterTime = DateFormatter()
                formatterTime.dateFormat = "HH:mm"
                print("Detail Item Time Start")
                print(detailItem?.timeStart)
                
                if (detailItem?.timeStart != nil){
                    
                    activityInfoCell.timeStart.text = convertDateToTime(detailItem!.timeStart ?? Date())
                }
                
                if (detailItem?.timeStop != nil){
                    activityInfoCell.timeStop.text = convertDateToTime(detailItem!.timeStop ?? Date())
                }
                
                activityInfoCell.notesTextField.text = detailItem?.notes
                
                return activityInfoCell
                
            } else if detailItem?.productType == "Product A"{
                let activityInfoACell = tableView.dequeueReusableCell(withIdentifier: "ActivityAInfoCell", for: [2,1]) as! ActivityAInfoCell
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                
                activityInfoACell.activityTypeField.text = detailItem?.activityType
                if (detailItem!.activityDate != nil){
                    
                    activityInfoACell.dateTextField.text = formatter.string(from: detailItem?.activityDate ?? Date())
                    
                }
                
                
                let formatterTime = DateFormatter()
                formatterTime.dateFormat = "HH:mm"
                print("Detail Item Time Start")
                print(detailItem?.timeStart)
                
                if (detailItem?.timeStart != nil){
                    activityInfoACell.timeStart.text = convertDateToTime(detailItem!.timeStart ?? Date())
                    
                }
                
                if (detailItem?.timeStop != nil){
                    activityInfoACell.timeStop.text = convertDateToTime(detailItem!.timeStop ?? Date())
                }
                
                activityInfoACell.reasonTextField.text = detailItem?.reason
                activityInfoACell.notesTextField.text = detailItem?.notes
                              
                
                return activityInfoACell
                
            } else if detailItem?.productType == "Product B"{
                let activityInfoBCell = tableView.dequeueReusableCell(withIdentifier: "ActivityBInfoCell", for: [2,1]) as! ActivityBInfoCell
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                
                activityInfoBCell.activityTypeField.text = detailItem?.activityType
                if (detailItem!.activityDate != nil){
                    
                    activityInfoBCell.dateTextField.text = formatter.string(from: detailItem?.activityDate ?? Date())
                    
                }
                
                
                
                let formatterTime = DateFormatter()
                formatterTime.dateFormat = "HH:mm"
                print("Detail Item Time Start")
                print(detailItem?.timeStart)
                
                if (detailItem?.timeStart != nil){
                    activityInfoBCell.timeStart.text = convertDateToTime(detailItem!.timeStart ?? Date())
                    
                }
                
                if (detailItem?.timeStop != nil){
                    activityInfoBCell.timeStop.text = convertDateToTime(detailItem!.timeStop ?? Date())
                }
                
                
                activityInfoBCell.notesTextField.text = detailItem?.notes
                
                return activityInfoBCell
                
            }
            
            
            
        }
        
        return UITableViewCell()
        
    }
    
    func configurePersonalInfo(_ cell: PersonalInfoCell, withCustomer customer: Customer) {
        
        
        
    }
    
    
    func showDatePicker(forField field: UITextField, mode : String){
        print("show date picker")
        print(field.tag)
        if (field.tag == 2){
            print("Date field called")
            datePicker.date = detailItem?.birthday ?? Date()
            
            datePicker.maximumDate = Date()
        } else if (field.tag == 4) {
            datePicker.date = Date()
            print("Date field activity called")
            datePicker.minimumDate = Date()
            
        } else if (field.tag == 5) {
            
            print("Time Start activity called")
            datePicker.minimumDate = Date()
            
        } else if (field.tag == 6) {
            
            print("Time STop activity called")
            datePicker.minimumDate = Date()
            
        }
        currentPicker = field.tag
        
        
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
        print("Current Picker")
        print(currentPicker)
        print(datePicker.date)
        if currentPicker == 2 {
            
            detailItem!.birthday = datePicker.date
        } else if currentPicker == 4{
            
            detailItem!.activityDate = datePicker.date
            
        } else if currentPicker == 5 {
            print(convertDateToTime(datePicker.date))
            detailItem!.timeStart = datePicker.date
            
        } else if currentPicker == 6{
            print(convertDateToTime(datePicker.date))
            detailItem!.timeStop = datePicker.date
            
        }
        
        
        self.view.endEditing(true)
        
        tableView.reloadData()
        
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerMode == "Product"{
            return products.count
        }else if pickerMode == "Activity" {
            return activities.count
        }
        
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerMode == "Product"{
            return products[row]
        }else if pickerMode == "Activity" {
            return activities[row]
        }
        
        
        return "dummy"
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerMode == "Product"{
            print("Product")
            print(products[row])
            detailItem!.productType = products[row]
            tableView.reloadData()
        }else if pickerMode == "Activity"{
            print("Activity")
            print(activities[row])
            detailItem!.activityType = activities[row]
            tableView.reloadData()
        }
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activeTextField = textField
        print(self.activeTextField.tag)
    }
    
    
    
    
    @IBAction func nameFieldChanged(_ sender: Any) {
        
        let nameField = sender as! UITextField
        print(nameField.text)
        detailItem!.name = nameField.text
        
    }
    
    @IBAction func birthdayFieldBegin(_ sender: Any) {
        
        let birthdayField = sender as! UITextField
        showDatePicker(forField: birthdayField, mode: "date")
    }
    
    @IBAction func birthdayFieldChanged(_ sender: Any) {
        
        let birthdayField = sender as! UITextField
        
        
        
    }
    
    @IBAction func productFieldBegin(_ sender: Any) {
        
        let productField = sender as! UITextField
        pickerMode = "Product"
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        productField.inputView = pickerView
        
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action:  #selector(donedatePicker))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        productField.inputAccessoryView = toolBar
        
        
        
    }
    
    @IBAction func productFieldChange(_ sender: Any) {
        
        let productField = sender as! UITextField
        
        
        
    }
    
    
    @IBAction func activityTypeBegin(_ sender: Any) {
        let activityField = sender as! UITextField
        pickerMode = "Activity"
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        activityField.inputView = pickerView
        
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action:  #selector(donedatePicker))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        activityField.inputAccessoryView = toolBar
        
    }
    
    @IBAction func activityFieldChange(_ sender: Any) {
        
        
        let activityField = sender as! UITextField
        
        print(activityField.text)
        print(detailItem!.productType)
        
    }
    
    
    @IBAction func activityDateFieldBegin(_ sender: Any) {
        let activityDateField = sender as! UITextField
        showDatePicker(forField: activityDateField, mode: "date")
        
    }
    
    
    @IBAction func activityDateFieldChange(_ sender: Any) {
        
        let activityDateField = sender as! UITextField
        //detailItem!.activityDate = convertDateToString(activityDateField.text!)
    }
    
    
    @IBAction func activityTimeStart(_ sender: Any) {
        let activityTimeStart = sender as! UITextField
        showDatePicker(forField: activityTimeStart, mode: "time")
    }
    
    @IBAction func activityTimeStartChange(_ sender: Any) {
        
        let activityTimeStart = sender as! UITextField
        // detailItem!.timeStart = convertDateToString(activityTimeStart.text!)
        
    }
    
    @IBAction func activityTimeStop(_ sender: Any) {
        
        let activityTimeStop = sender as! UITextField
        showDatePicker(forField: activityTimeStop, mode: "time")
        
    }
    
    @IBAction func activityTimeStopChange(_ sender: Any) {
        
        let activityTimeStop = sender as! UITextField
        //detailItem!.timeStop = convertDateToString(activityTimeStop.text!)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 10:
            print(textField.text)
            detailItem!.notes = textField.text
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 10:
            print(textField.text)
            detailItem!.notes = textField.text
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func convertDateToString(_ stringDate: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: stringDate)
        
        return date ?? Date()
    }
    
    
    func convertDateToTime(_ dataDate: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: dataDate)
        
        return dateString
    }
    
}







