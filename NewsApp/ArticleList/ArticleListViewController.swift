//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Муслим on 26.03.2024.
//

import UIKit

final class ArticleListViewController: UIViewController {
    
    private let imagesProvider = ImagesProvider()
    private lazy var networkService = ArticleListNetworkService()
    
    private var page = 1
    private var items: [Article] = []
    private var selectedCategory = Category.allNews
    
    
    //MARK: - UI Elements
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainColor
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        return tableView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        return indicator
    }()
    
    private let customNavigationLeftView = SelectCategoryView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.mainColor
        
        title = "News"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTapped)
        )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedCategoryViewTapped))
        customNavigationLeftView.addGestureRecognizer(tapGesture)
        customNavigationLeftView.configuere(title: selectedCategory.displayTitle)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: customNavigationLeftView
        )
        
        setupTableViewLayout()
        setupActivityIndicatorLayout()
        
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        
        activityIndicator.startAnimating()
        
        fetchData()
    }
    
    private func fetchData() {
        networkService.fetchData(q: selectedCategory.requestTitle, page: page) {[weak self] articles in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.items += articles
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.tableView.tableFooterView = nil
                self.tableView.tableHeaderView = nil
            }
        }
    }
    
    
    // MARK: - Private Methods
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupActivityIndicatorLayout() {
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc
    private func searchButtonTapped() {
        
    }
    
    @objc
    private func selectedCategoryViewTapped() {
        let vc = SelectCategoryViewController(selectedItem: selectedCategory)
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func TableLoadingView() -> UIView {
        let view = UIView(
            frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100))
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
}

// MARK: - UITableViewDataSource

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListTableViewCell.reuseID,
            for: indexPath
        ) as? NewsListTableViewCell else {
            fatalError("Can not dequeue NewsListTableViewCell")
        }
        let item = items[indexPath.row]
        
        cell.selectionStyle = .none
        cell.configure(article: item, imagesProvider: imagesProvider)
        
        return cell
    }
}
// MARK: - UITableViewDelegate

extension ArticleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let image = imagesProvider.image(for: item.urlToImage) ?? UIImage()
        let vc = ArticleInfoViewController(item: item, image: image)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == items.count - 6 else { return }
        
        tableView.tableFooterView = TableLoadingView()
        page += 1
        fetchData()
    }
}

//MARK: - SelectCategoryViewControllerDelegate

extension ArticleListViewController: SelectCategoryViewControllerDelegate {
    
    func doneButtonTapped(selectedCategory: Category) {
        if self.selectedCategory == selectedCategory {
            return
        }
        
        self.selectedCategory = selectedCategory
        
        customNavigationLeftView.configuere(title: selectedCategory.displayTitle)
        tableView.tableHeaderView = TableLoadingView()
        items = []
        fetchData()
    }
}
