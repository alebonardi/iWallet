//
//  Transaction+CoreDataProperties.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 20/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction");
    }

    @NSManaged public var descr: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: NSDate?
    @NSManaged public var isExpense: Bool

}
