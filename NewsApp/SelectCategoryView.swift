//
//  SelectCategoryView.swift
//  NewsApp
//
//  Created by Муслим on 18.04.2024.
//

import UIKit

final class SelectCategoryView: UIView {
    
    private let leadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "newspaper")
        imageView.tintColor = .red
        return imageView
    }()
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private let trailingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.addArrangedSubview(leadingImageView)
        stackView.addArrangedSubview(titlelabel)
        stackView.addArrangedSubview(trailingImageView)
    }
    
    func configuere(title: String) {
        titlelabel.text = title
    }
}
