//
//  GeneralTableViewController.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 19/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import UIKit

class GeneralTableViewController: UITableViewController {

    var income = 0.0
    var expenses = 0.0
    
    @IBOutlet var incomeTextField: UITextField!
    @IBOutlet var expensesTextField: UITextField!
    @IBOutlet var totalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTextFields(income: Double, expenses: Double) {
        self.income = income
        self.expenses = expenses
        incomeTextField.text = "£ " + String(format: "%.02f", income)
        expensesTextField.text = "£ " + String(format: "%.02f", expenses)
        totalTextField.text = "£ " + String(format: "%.02f", income - expenses)
    }

}
