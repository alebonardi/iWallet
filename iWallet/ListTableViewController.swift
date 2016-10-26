//
//  ListTableViewController.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 19/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    
    @IBOutlet var choosePeriodSegmentedControl: UISegmentedControl!
    
    var period: Period = Period.allTime
    
    @IBAction func periodSegmentedControllerWasChanged(_ sender: AnyObject) {
        period = Period(rawValue: choosePeriodSegmentedControl.selectedSegmentIndex)!
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        for ts in Transactions.list {
            count += getPartialCount(count: count, date: ts[0].date)
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Pre-condition: section is <= Transactions.list.count
        var count = -1
        var date: Date? = nil
        
        for ts in Transactions.list {
            count += getPartialCount(count: count, date: ts[0].date)
            if count == section {
                date = ts[0].date
                break
            }
        }
        return DateFormatter.localizedString(from: date!, dateStyle: DateFormatter.Style.medium,
                                             timeStyle: DateFormatter.Style.none)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Transactions.list[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        
        var count = -1
        
        for ts in Transactions.list {
            count += getPartialCount(count: count, date: ts[0].date)
            if count == indexPath.section {
                let transaction = ts[indexPath.row]
                cell.descriptionLabel.text = transaction.descr
                cell.dateLabel.text = formatter.string(from: transaction.date)
                cell.amountLabel.text = String(format: "%.02f", transaction.amount)
                if transaction.isExpense {
                    cell.isExpenseImageView.backgroundColor = UIColor.red
                } else {
                    cell.isExpenseImageView.backgroundColor = UIColor.green
                }
                break
            }
        }
        return cell
    }
    
    func getPartialCount(count: Int, date: Date) -> Int {
        switch period.rawValue {
        case 0: return 1
        case 1: if date >= monthAgo! && date <= now {
            return 1
            }
        case 2: if date > weekAgo! && date <= now {
            return 1
            }
        case 3: if Calendar.current.isDateInToday(date) {
            return 1
            }
        default: break
        }
        return 0
    }
    
}
