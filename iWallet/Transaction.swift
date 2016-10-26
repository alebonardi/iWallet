//
//  Transaction.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 18/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Transaction: NSManagedObject {
    
    @NSManaged var descr: String
    @NSManaged var amount: Double
    @NSManaged var date: Date
    @NSManaged var isExpense: Bool
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, descr: String, amount: Double, date: Date, isExpense: Bool) -> Transaction {
        let newTransaction = NSEntityDescription.insertNewObject(forEntityName: "Transaction", into: moc) as! Transaction
        newTransaction.descr = descr
        newTransaction.amount = amount
        newTransaction.date = date
        newTransaction.isExpense = isExpense
        return newTransaction
    }
    
}


