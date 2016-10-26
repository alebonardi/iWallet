//
//  AddTransactionViewController.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 17/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import UIKit
import CoreData

class AddTransactionViewController: UITableViewController {
    
    var transaction: Transaction!
    var datePickerHidden = true

    @IBOutlet var transactionTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var transactionDatePicker: UIDatePicker!
    @IBAction func hideKeyboard(_ sender: UITextField) {
    }
    @IBAction func transactionDatePickerChanged(_ sender: AnyObject) {
        getDatePicker()
    }
    @IBAction func amountEditingEnded(_ sender: AnyObject) {
        //let formatter = NumberFormatter()
        //formatter.numberStyle = NumberFormatter.Style.currency
        //formatter.locale = Locale(identifier: "en_UK")
        let numberFromField = NSString(string: amountTextField.text!).doubleValue
        //amountTextField.text = formatter.string(from: NSNumber(value: numberFromField))
        amountTextField.text = String(numberFromField)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatePicker()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddTransactionViewController.hydeKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 {
            toggleDatePicker()
        }
    }

    
    func hydeKeyboard() {
        self.view.endEditing(true)
        if !datePickerHidden {
            toggleDatePicker()
        }
    }
    
    func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 2 && indexPath.row == 1 {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func getDatePicker() {
        dateLabel.text = DateFormatter.localizedString(from: transactionDatePicker.date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveNewTransaction" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            let dateFromString: Date = dateFormatter.date(from: dateLabel.text!)!
            
            // Get double value from amountTextField
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            var isExpense = true
            if transactionTypeSegmentedControl.selectedSegmentIndex == 1 {
                isExpense = false
            }
            
            transaction = Transaction.createInManagedObjectContext(moc: managedContext, descr: descriptionTextField.text!, amount: NSString(string: amountTextField.text!).doubleValue, date: dateFromString, isExpense: isExpense)
            do {
                try managedContext.save()
            } catch {}
        }
    }
    
}
