//
//  FavoriteStorage.swift
//  NewsApp
//
//  Created by Муслим on 18.04.2024.
//

final class FavoriteStorage {
    
    static let shared = FavoriteStorage()
    
    var items: [Article] = []
    
    private init() {}
    
    func handle(_ element: Article) {
        if contains(element) {
            items.removeAll { $0 == element }
        } else {
            items.append(element)
        }
    }
    
    func contains(_ element: Article) -> Bool {
        items.contains { $0 == element }
    }
}
