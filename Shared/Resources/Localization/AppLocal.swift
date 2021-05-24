//
//  LocalizationManager.swift
//
//  Created by Ahmed Magdi Abdelkhalek on 08.07.19.
//  Copyright © 2019 Dolphin Technologies GmbH. All rights reserved.
//

import UIKit

class AppLocal {
    static var `default`: AppLocal = AppLocal()

    private var extraLocalMapping: [String: Strings] = [:]

    func addExtraLocal(key: String, value: Strings) {
        extraLocalMapping[key] = value
    }

    public static func hasKey(key: String) -> Strings? {
        for tmpKey in Strings.allCases where tmpKey.rawValue == key {
            return tmpKey
        }
        return nil
    }

    subscript(key: String) -> String {
        if let tmpKey = AppLocal.hasKey(key: key) {
            return NSLocalizedString(GeneratedStrings.shared.getLocal(tmpKey), bundle: Bundle.main, comment: "")
        } else if let externalKey = extraLocalMapping[key] {
            return AppLocal.default[externalKey]
        } else {
            return NSLocalizedString(key, bundle: Bundle.main, comment: "")
        }
    }
}

