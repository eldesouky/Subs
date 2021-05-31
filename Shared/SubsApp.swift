//
//  SubsApp.swift
//  Shared
//
//  Created by Mahmoud Eldesouky on 23.05.21.
//

import SwiftUI
import PartialSheet

@main
struct SubsApp: App {
    let persistenceController = PersistenceController.shared
    let sheetManager: PartialSheetManager = PartialSheetManager()

    var body: some Scene {
        WindowGroup {
            DashboardView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(sheetManager)
                    
        }
    }
}
