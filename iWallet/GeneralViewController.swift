//
//  GeneralViewController.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 17/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import UIKit
import CoreData

var DBTransactions = [NSManagedObject]()
var Transactions = TransactionsList()
var Dates = [Date]()

var sumExpenses: Double = 0.0
var sumIncome: Double = 0.0

var startPeriod: Date = Date()
var endPeriod: Date = Date()

let now = Date()
let calendar = Calendar.current
let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())
let monthAgo = calendar.date(byAdding: .month, value: -1, to: Date())
let components = calendar.dateComponents([.year, .month], from: Date())
let startOfMonth = calendar.date(from: components)

var period: Period = Period.allTime

let budget: Double = 1500


class GeneralViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var container: UIView!
    @IBOutlet var choosePeriodSegmentedControl: UISegmentedControl!
    @IBOutlet var lastWeekExpensesTextField: UITextField!
    @IBOutlet var lastMonthExpensesTextField: UITextField!
    @IBOutlet var graphView: GraphView!
    @IBOutlet var graphViewLeftLabel: UILabel!
    
    @IBAction func periodSegmentedControlHasChanged(_ sender: AnyObject) {
        period = Period(rawValue: choosePeriodSegmentedControl.selectedSegmentIndex)!
        updateSums()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //deleteAllTransactions()
        fetchTransactions()
        view.addSubview(container)
    }
    
    func fetchTransactions() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        let managedObjectContext = appDelegate.managedObjectContext
        do {
            let fetchResult = try managedObjectContext.fetch(fetchRequest) as? [Transaction]
            if fetchResult != nil {
                DBTransactions = fetchResult!
            }
        } catch {}
        for i in 0 ..< DBTransactions.count {
            let transaction = DBTransactions[i] as! Transaction
            Transactions.add(transaction: transaction)
        }
        updateSums()
        updatePeriods()
    }
    
    func deleteAllTransactions() {
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        do {
            let transactions = try managedObjectContext.fetch(fetchRequest) as? [Transaction]
            for transaction in transactions! {
                let managedObjectData = transaction as NSManagedObject
                managedObjectContext.delete(managedObjectData)
            }
            try managedObjectContext.save()
        } catch {}
        DBTransactions.removeAll()
        Transactions.list.removeAll()
    }
    
    func updateSums() {
        let tableView : GeneralTableViewController = self.childViewControllers[0]
            as! GeneralTableViewController
        tableView.refreshTextFields(income: Transactions.sum(period: period, isExpense: false),
                                    expenses: Transactions.sum(period: period, isExpense: true))
    }
    
    func updatePeriods() {
        lastWeekExpensesTextField.text = "£ " + String(format: "%.02f",
                                                Transactions.sum(period: Period.lastWeek, isExpense: true))
        lastMonthExpensesTextField.text = "£ " + String(format: "%.02f",
                                                 Transactions.sum(period: Period.lastMonth, isExpense: true))
        graphView.expenseBudgetRatio = Transactions.sum(period: Period.thisMonth, isExpense: true) / budget
        graphViewLeftLabel.text = "£ " + String(format: "%.02f", budget - Transactions.sum(period: Period.thisMonth, isExpense: true))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelToGeneralViewController(segue:UIStoryboardSegue){}
    
    @IBAction func saveNewTransaction(segue:UIStoryboardSegue){
        if let addTransactionViewController = segue.source as? AddTransactionViewController {
            let transaction = addTransactionViewController.transaction
            Transactions.add(transaction: transaction!)
            DBTransactions.append(transaction!)
            updateSums()
            updatePeriods()
        }
    }

}
