//
//  Category.swift
//  NewsApp
//
//  Created by Муслим on 19.04.2024.
//

import Foundation

enum Category: CaseIterable {
    case allNews
    case tesla
    case apple
    case google
    case amazon
    
    var displayTitle: String {
        switch self {
        case .allNews:
            return "All News"
        case .tesla:
            return "Tesla"
        case .apple:
            return "Apple"
        case .google:
            return "Google"
        case .amazon:
            return "Amazon"
        }
    }
        
    var requestTitle: String? {
        switch self {
        case .allNews:
            return nil
        case .tesla:
            return "tesla"
        case .apple:
            return "apple"
        case .google:
            return "google"
        case .amazon:
            return "amazon"
        }
    }
}
