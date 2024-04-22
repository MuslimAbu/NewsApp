//
//  ArticleListViewControllerProvider.swift
//  NewsApp
//
//  Created by Муслим on 16.04.2024.
//

import UIKit

struct ArticleListViewControllerProvider {
    
    static func articleListViewController(imagesProvider: ImagesProvider) -> UIViewController {
        let isUpdatedModeEnabled = UserDefaults.standard.bool(forKey: "actionSwitch")
        
        if isUpdatedModeEnabled {
            return CarouselArticleListViewController(imagesProvider: imagesProvider)
        } else {
            return ArticleListViewController(imagesProvider: imagesProvider)
        }
    }
}
