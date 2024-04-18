//
//  ArticleListViewControllerProvider.swift
//  NewsApp
//
//  Created by Муслим on 16.04.2024.
//

import UIKit

struct ArticleListViewControllerProvider {
    
    static var articleListViewController: UIViewController {
        let isUpdatedModeEnabled = UserDefaults.standard.bool(forKey: "actionSwitch")
        
        if isUpdatedModeEnabled {
            return CarouselArticleListViewController()
        } else {
            return ArticleListViewController()
        }
    }
}
