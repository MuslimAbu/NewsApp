//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Муслим on 26.03.2024.
//

import UIKit

final class NewsListViewController: UIViewController {
    
    private var items = [
        Article(image: UIImage(named: "cat")!, title: "Cats safari, lets go party every day and every night"),
        Article(image: UIImage(named: "cat")!, title: "Cats safari, lets go party every day and every night"),
        Article(image: UIImage(named: "cat")!, title: "Cats safari, lets go party every day and every night"),
        Article(image: UIImage(named: "cat")!, title: "Cats safari, lets go party every day and every night"),
        Article(image: UIImage(named: "cat")!, title: "Cats safari, lets go party every day and every night")
    ]
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.mainColor
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        return tableView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.mainColor
        
        title = "News"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTapped)
        )
        
        setupTableViewLayout()
        setupActivityIndicatorLayout()
        
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.reuseID)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        activityIndicator.startAnimating()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {_ in 
            self.activityIndicator.stopAnimating()
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
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
}

// MARK: - UITableViewDataSource

extension NewsListViewController: UITableViewDataSource {
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
        cell.configure(image: item.image, title: item.title, timestamp: item.timestamp)
        
        return cell
    }
}
// MARK: - UITableViewDelegate

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let vc = NewsInfoViewController(item: item)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
