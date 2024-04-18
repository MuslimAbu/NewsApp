//
//  NewsInfoView.swift
//  NewsApp
//
//  Created by Муслим on 31.03.2024.
//

import UIKit

final class ArticleInfoView: UIView {
    
    var isFavorite: Bool = false {
        didSet {
            updateAddToFavoritesButton()
        }
    }
    
    //MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let goToSourceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to source", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    let addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        setupScrollViewLayout()
        setupContentViewLayout()
        setupImageViewLayout()
        setupTitleLabelLayout()
        setupDescriptionTextViewLayout()
        setupGoToSourceButtonLayout()
        setupAddToFavoritesButtonLayout()
    }
    
    private func setupScrollViewLayout() {
        addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupContentViewLayout() {
        scrollView.addSubview(contentView)
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupImageViewLayout() {
        contentView.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    private func setupTitleLabelLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
    }
    
    private func setupDescriptionTextViewLayout() {
        contentView.addSubview(descriptionTextView)
        
        descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func setupGoToSourceButtonLayout() {
        contentView.addSubview(goToSourceButton)
        
        goToSourceButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        goToSourceButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 24).isActive = true
        goToSourceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
    }
    
    private func setupAddToFavoritesButtonLayout() {
        imageView.addSubview(addToFavoritesButton)
        
        addToFavoritesButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -24).isActive = true
        addToFavoritesButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24).isActive = true
        addToFavoritesButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        addToFavoritesButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func updateDescription(_ text: String?) {
        guard let text = text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 16
        paragraphStyle.paragraphSpacing = 16
        
        descriptionTextView.attributedText = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.systemFont(ofSize: 18)
            ]
        )
    }
    
    private func updateAddToFavoritesButton() {
        if isFavorite {
            addToFavoritesButton.tintColor = .orange
        } else {
            addToFavoritesButton.tintColor = .white
        }
    }
    
    func configuere(image: UIImage, title: String, description: String) {
        imageView.image = image
        titleLabel.text = title
        
        updateDescription(description)
        updateAddToFavoritesButton()
    }
}
