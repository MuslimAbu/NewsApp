//
//  UpdatedArticleListViewController.swift
//  NewsApp
//
//  Created by Муслим on 16.04.2024.
//

import UIKit

final class CarouselArticleListViewController: UIViewController {
    
    private let networkService = ArticleListNetworkService()
    private let imagesProvider = ImagesProvider()
    
    private var page = 1
    
    private var items: [Article] = []
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        return indicator
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        collectionView.register(
            CarouselArticleListCollectionViewCell.self,
            forCellWithReuseIdentifier: CarouselArticleListCollectionViewCell.reuseId
        )
        
        setupCollectionViewLayout()
        
        title = "News"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        activityIndicator.startAnimating()
        
        fetchData()
    }
    
    //MARK: - Private Methods
    
    private func fetchData() {
        networkService.fetchData(q: nil, page: page) {[weak self] articles in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.items += articles
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension CarouselArticleListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselArticleListCollectionViewCell.reuseId,
            for: indexPath
        ) as? CarouselArticleListCollectionViewCell else {
            fatalError("Can not dequeue CarouselArticleListCollectionViewCell")
        }
        
        let item = items[indexPath.item]
        
        cell.configure(article: item, imagesProvider: imagesProvider)
        
        return cell
    }
}

extension CarouselArticleListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, 
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    )-> CGSize {
        CGSize(width: collectionView.bounds.size.width - 100, height: collectionView.bounds.size.height - 50)
    }
}

extension CarouselArticleListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        let image = imagesProvider.image(for: item.urlToImage) ?? UIImage()
        let vc = ArticleInfoViewController(item: item, image: image)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
