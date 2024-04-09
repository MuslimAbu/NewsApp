//
//  NewsInfoViewController.swift
//  NewsApp
//
//  Created by Муслим on 31.03.2024.
//

import UIKit

final class NewsInfoViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = NewsInfoView()
    
    private let item: Article
    
    // MARK: - Init
    
    init(item: Article) {
        self.item = item
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        mainView.configuere(image: UIImage(), title: item.title, description: item.description)
    }

}
