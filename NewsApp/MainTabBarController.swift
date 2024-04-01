//
//  MainTabBarController.swift
//  NewsApp
//
//  Created by Муслим on 26.03.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private var newsListViewController: UINavigationController {
        let viewController = NewsListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "News",
            image: UIImage(systemName: "newspaper"),
            selectedImage: UIImage(systemName: "newspaper.fill")
        )
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
    
    private var favoriteNewsListViewController: UINavigationController {
        let viewController = FavoriteNewsListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Saved",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )
        return navigationController
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [newsListViewController, favoriteNewsListViewController]
        
        tabBar.tintColor = .red
        
        tabBar.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
