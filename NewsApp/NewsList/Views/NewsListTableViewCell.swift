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
    
    // MARK: - Private methods
    
    private func setup() {
        contentView.backgroundColor = Colors.mainColor
        
        setupArticleImageViewLayout()
        setupTitleLabelLayout()
        setupTimestampLabelLayout()
        
    }
    
    private func setupArticleImageViewLayout() {
        contentView.addSubview(articleImageView)
        
        articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        articleImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupTitleLabelLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        titleLabel.topAnchor.constraint(equalTo: articleImageView.topAnchor).isActive = true
    }
    
    private func setupTimestampLabelLayout() {
        contentView.addSubview(timestampLabel)
        
        timestampLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        timestampLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func configure(image: UIImage, title: String?, timestamp: String) {
        articleImageView.image = image
        titleLabel.text = title
        timestampLabel.text = timestamp
    }
}
