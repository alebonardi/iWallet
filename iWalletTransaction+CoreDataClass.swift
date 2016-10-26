//
//  iWalletTransaction+CoreDataClass.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 21/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import Foundation
import CoreData

//@objc(Transaction)
public class Transaction: NSManagedObject {

        class func createInManagedObjectContext(moc: NSManagedObjectContext, descr: String, amount: Double, date: Date, isExpense: Bool) -> Transaction {
            let newTransaction = NSEntityDescription.insertNewObject(forEntityName: "Transaction", into: moc) as! Transaction
            newTransaction.descr = descr
            newTransaction.amount = amount
            newTransaction.date = date as NSDate?
            newTransaction.isExpense = isExpense
            return newTransaction
        }
        

    

    
}
