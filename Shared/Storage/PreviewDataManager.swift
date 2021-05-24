////
////  PreviewDataManager.swift
////  Subs (iOS)
////
////  Created by Ahmed Magdi on 24/05/2021.

import Foundation
import CoreData

class PreviewDataManager: DataManager {
    static var preview: DataManager = PreviewDataManager()
    override var dbHelper: CoreDataHelper { CoreDataHelper.preview }
}
