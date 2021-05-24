//
//  Dashboard+ViewModel.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import Foundation
import Combine

extension DashboardView {
    class ViewModel : ObservableObject {
        
        @Published var items: [Subscription] = []
//
        func fetchData() {
            items = DataManager.shared.getItems()
        }
        
        private func addItem() {
//            withAnimation {
//
//                Subscription.createDummy(context: viewContext)
//
//                do {
//                    try viewContext.save()
//                } catch {
//
//                    let nsError = error as NSError
//                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                }
//            }
        }

        private func deleteItems(offsets: IndexSet) {
//            withAnimation {
//                offsets.map { subscriptions[$0] }.forEach(viewContext.delete)
//
//                do {
//                    try viewContext.save()
//                } catch {
//
//                    let nsError = error as NSError
//                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                }
//            }
        }
    }
}
