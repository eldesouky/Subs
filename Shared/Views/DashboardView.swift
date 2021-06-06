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
    @StateObject var viewModel = ViewModel()
    @State var showPermissionAlert = false
    
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(subscriptions) { sub in
                        SubscriptionCell(content: sub)
                            .listRowInsets(EdgeInsets())
                            .padding(.bottom, 10)
                    }
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
            .navigationBarTitle(AppLocal.default[.title_subscription], displayMode: .inline)
            .navigationBarItems(leading: EditButton(),trailing: Button(action: {
                createNewItem.toggle()
            }, label: { Label("", systemImage: "plus") }))
            .sheet(isPresented: $createNewItem) {
                NewSubView()
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            viewModel.addItem()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            //  DashboardView().previewDevice("iPad (8th generation)").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
