//
//  ContentView.swift
//  iExpense
//
//  Created by Adam Miller on 7/15/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        ExpenseListItem(item: item)
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal Expenses")
                }
                
                Section {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        ExpenseListItem(item: item)
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Business Expenses")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpenseListItem: View {
    
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if item.amount > 100 {
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundColor(.red)
            } else if item.amount > 10 {
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundColor(.yellow)
            } else  {
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundColor(.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
