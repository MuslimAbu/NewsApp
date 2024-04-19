//
//  NewsListTableViewCell.swift
//  NewsApp
//
//  Created by Муслим on 29.03.2024.
//

import UIKit

final class NewsListTableViewCell: UITableViewCell {
    
    static let reuseID = "NewsListTableViewCell"
    
    // MARK: - UI Elements
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    private var timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - UI Elements
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        articleImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        timestampLabel.text = nil
    }
    
    // MARK: - Private methods
    
    private func setup() {
        contentView.backgroundColor = Colors.mainColor
        
        setupArticleImageViewLayout()
        setupTitleLabelLayout()
        setupDescriptionLabelLayout()
        setupTimestampLabelLayout()
    }
    
    private func setupArticleImageViewLayout() {
        contentView.addSubview(articleImageView)
        
        articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        articleImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupTitleLabelLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: articleImageView.topAnchor).isActive = true
    }
    
    private func setupDescriptionLabelLayout() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func setupTimestampLabelLayout() {
        contentView.addSubview(timestampLabel)
        
        timestampLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        timestampLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    func configure(article: Article, imagesProvider: ImagesProvider) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        timestampLabel.text = article.publishedAt
        
        imagesProvider.image(for: article.urlToImage) { [weak self] image in
            DispatchQueue.main.async {
                if let image = image {
                    self?.articleImageView.image = image
                } else {
                    self?.articleImageView.image = UIImage(named: "article")
                }
            }
        }
    }
}
