//
//  SubsApp.swift
//  Shared
//
//  Created by Mahmoud Eldesouky on 23.05.21.
//

import SwiftUI

@main
struct SubsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
                DashboardView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
