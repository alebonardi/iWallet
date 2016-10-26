//
//  TransactionsList.swift
//  iWallet
//
//  Created by Alessandro Bonardi on 18/09/2016.
//  Copyright © 2016 Alessandro Bonardi. All rights reserved.
//

import Foundation



class TransactionsList {
    
    var list: [[Transaction]]
    
    init() {
        list = [[Transaction]]()
    }
    
    func add(transaction: Transaction) {
        var isNewDate: Bool = true
        
        for i in 0 ..< list.count {
            if list[i][0].date == transaction.date {
                isNewDate = false
                list[i].insert(transaction, at: 0)
                break
            }
        }
        
        if isNewDate {
            let newTransactionArray = [transaction]
            if !list.isEmpty {
                var index = 0
                while index < list.count && list[index][0].date > transaction.date {
                    index += 1
                }
                list.insert(newTransactionArray, at: index)
            } else {
                list.insert(newTransactionArray, at: 0)
            }
        }
        
    }
    
    func sum(period: Period, isExpense: Bool) -> Double {
        var s = 0.0
        let now = Date()
        for ts in list {
            for t in ts {
                if t.isExpense == isExpense {
                    switch period.rawValue {
                        case 0: s += t.amount
                        case 1: if t.date >= monthAgo! && t.date <= now {
                                    s += t.amount
                                }
                        case 2: if t.date > weekAgo! && t.date <= now {
                                    s += t.amount
                                }
                        case 3: if Calendar.current.isDateInToday(t.date) {
                                    s += t.amount
                                }
                        case 4: if t.date > startOfMonth! && t.date <= now {
                                    s += t.amount
                                }
                        default: break
                    }
                }
            }
        }
        return s
    }
    
    func getNumItems(period: Period) -> Int {
        var count = 0
        
        for ts in list {
            for t in ts {
                switch period.rawValue {
                    case 0: count += 1
                    case 1: if t.date >= monthAgo! && t.date <= now {
                                count += 1
                            }
                    case 2: if t.date > weekAgo! && t.date <= now {
                                count += 1
                            }
                    case 3: if Calendar.current.isDateInToday(t.date) {
                                count += 1
                            }
                    default: break
                }
            }
        }
        return count
    }

    
}
