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
    
    @State var showTotalSubscriptions = false
    @State var createNewItem: Bool = false
    
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    List {
                        ForEach(subscriptions) { sub in
                            SubscriptionCell(content: sub)
                                .listRowInsets(EdgeInsets())
                                .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            
                        }
                        .onDelete(perform: deleteItems)
                    }
                    if showTotalSubscriptions{
                        TotalSubscriptions()
                            .transition(.move(edge: .bottom))
                    }
                    AverageExpenses()
                        .onTapGesture {
                            withAnimation {
                                showTotalSubscriptions.toggle()
                            }
                        }
                    
                }
                .background(Color.white)
            }
            .navigationBarTitle("Subscriptions", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),trailing: Button(action: {
                createNewItem.toggle()
            }, label: { Label("", systemImage: "plus") }))
            .sheet(isPresented: $createNewItem) {
                NewSubView(viewModel: .init(context: viewContext))
            }
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
        }
    }
}
