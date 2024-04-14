//
//  NewsInfoViewController.swift
//  NewsApp
//
//  Created by Муслим on 31.03.2024.
//

import UIKit
import SafariServices

final class ArticleInfoViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = ArticleInfoView()
    private let item: Article
    private let image: UIImage
    
    // MARK: - Init
    
    init(item: Article, image: UIImage) {
        self.item = item
        self.image = image
        
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
        
        mainView.configuere(image: image, title: item.title, description: item.description)
        
        mainView.goToSourceButton.addTarget(self, action: #selector(goToSourceButtonTapped), for: .touchDown)
    }
    
    //MARK: - Private Methods
    
    @objc
    
    private func goToSourceButtonTapped() {
        let vc = SFSafariViewController(url: item.url)
        
        present(vc, animated: true)
    }

}
