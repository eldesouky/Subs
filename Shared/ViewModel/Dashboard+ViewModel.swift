//
//  Dashboard+ViewModel.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import Foundation
import Combine

extension DashboardView {
    class ViewModel : BaseViewModel {

        func addItem() {
            Subscription.createDummy(context: context)

              do {
                  try context.save()
              } catch {

                  let nsError = error as NSError
                  fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
              }
        }
    }
}
