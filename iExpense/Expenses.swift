//
//  Expenses.swift
//  iExpense
//
//  Created by Adam Miller on 7/16/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
