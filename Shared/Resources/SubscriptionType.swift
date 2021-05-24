//
//  SubscriptionType.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 24.05.21.
//

import Foundation

enum SubscriptionType: Int16, CaseIterable {
    case netflix, appleArcade, appleMusic, youtubePremium, youtubeMusic
    
    func getName()->String {
        switch self {
        case .netflix:
           return "Netflix"
        case .appleArcade:
            return "Apple Arcade"
        case .appleMusic:
            return  "Apple Music"
        case .youtubePremium:
            return "Youtube Premium"
        case .youtubeMusic:
            return "Youtube Music"
        }
    }
    
    func getIcon()-> String {
        switch self {
        case .netflix:
            return "netflix_logo"
        case .appleArcade, .appleMusic:
            return "apple_logo"
        case .youtubePremium, .youtubeMusic:
            return "youtube_logo"
        }
    }
    
    func getColor() -> String {
        switch self {
        case .netflix:
            return "A2221D"
        case .appleArcade, .appleMusic:
            return  "000000"
        case .youtubePremium, .youtubeMusic:
            return  UIColor.red.hexStringFromColor()
        }
    }
}
