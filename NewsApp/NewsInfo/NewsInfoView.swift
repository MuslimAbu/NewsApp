//
//  NewsInfoView.swift
//  NewsApp
//
//  Created by Муслим on 31.03.2024.
//

import UIKit

final class NewsInfoView: UIView {
    
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
        textView.font = Fonts.chango(size: 15)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = "English texts for beginners to practice reading and comprehension online and for free. Practicing your comprehension of written English will both improve your vocabulary and understanding of grammar and word order. The texts below are designed to help you develop while giving you an instant evaluation of your progress. Prepared by experienced English teachers, the texts, articles and conversations are brief and appropriate to your level of proficiency. Take the multiple-choice quiz following each text, and you'll get the results immediately. You will feel both challenged and accomplished! You can even download (as PDF) and print the texts and exercises. It's enjoyable, fun and free. Good luck!"
        return textView
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
        setupScrollViewLayout()
        setupContentViewLayout()
        setupImageViewLayout()
        setupTitleLabelLayout()
        setupDescriptionTextViewLayout()
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
        descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configuere(image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}
