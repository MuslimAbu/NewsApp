//
//  FavoriteNewsListViewController.swift
//  NewsApp
//
//  Created by Муслим on 27.03.2024.
//

import UIKit

final class FavoriteArticleListViewController: UIViewController {
    
    private var items: [Article] {
        FavoriteStorage.shared.items
    }
    
    private let imagesProvider: ImagesProvider
    
// MARK: - UI Elements
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainColor
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        return tableView
    }()
    
// MARK: - Init
    
    init(imagesProvider: ImagesProvider) {
        self.imagesProvider = imagesProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.mainColor
        
        title = "Saved"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: ArticleListTableViewCell.reuseID)
        
        setupTableViewLayout()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoriteListChanged),
            name: FavoriteStorage.favoritesChangedNotification,
            object: nil
        )
    }
    
// MARK: - Private methods
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc
    private func favoriteListChanged() {
        tableView.reloadData()
    }
}
// MARK: - UITableViewDataSource

extension FavoriteArticleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ArticleListTableViewCell.reuseID,
            for: indexPath
        ) as? ArticleListTableViewCell else {
            fatalError("Can not dequeue ArticleListTableViewCell")
        }
        
        let item = items[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configure(article: item, imagesProvider: imagesProvider)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoriteArticleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let image = imagesProvider.image(for: item.urlToImage) ?? UIImage()
        let vc = ArticleInfoViewController(item: item, image: image)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

