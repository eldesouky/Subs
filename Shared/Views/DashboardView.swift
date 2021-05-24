//
//  ContentView.swift
//  Shared
//
//  Created by Mahmoud Eldesouky on 23.05.21.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Subscription.firstBill, ascending: true)],
        animation: .default)
    private var subscriptions: FetchedResults<Subscription>
    
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(subscriptions) { sub in
                    SubscriptionCell(content: sub)
                        .listRowInsets(EdgeInsets())
                        .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Subscriptions", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),trailing: Button(action: addItem, label: { Label("", systemImage: "plus") }))

        }
    }

    private func addItem() {
        withAnimation {
            
            Subscription.createDummy(context: viewContext)

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { subscriptions[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
               
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            DashboardView().previewDevice("iPad (8th generation)").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
