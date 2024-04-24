//
//  ArticleDetailViewController.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 18/04/2024.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var coordinator: (any Coordinator)?
    var viewModel: ArticleDetailViewModel?

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.lightGray // Placeholder color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Image")
        imageView.accessibilityIdentifier = AccessibilityIdentifier.articleDetailImageView
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // Allow multiple lines
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.textColor = .primaryLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = AccessibilityIdentifier.articleDetailTitleLabel
        return label
    }()
    
    let articleDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .primaryLabelColor
        label.font = UIFont(name: "Helvetica", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read On Website", for: .normal)
        button.backgroundColor = .primaryLabelColor
        button.setTitleColor(.primaryBackgroundColor, for: .normal)
        button.layer.cornerRadius = 24.0
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 22.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Inner Types

    private enum Constants {
        static let standardPadding = 16.0
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackgroundColor
        setupView()
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        do {
            view.addSubview(scrollView)
            do {
                scrollView.addSubview(contentView)
                do {
                    contentView.addSubview(imageView)
                    contentView.addSubview(titleLabel)
                    contentView.addSubview(articleDetailLabel)
                    contentView.addSubview(actionButton)
                }
            }
        }
        
        actionButton.addTarget(self, action: #selector(didTapReadOnWebsite), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // Constraints for scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Constraints for contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Constraints for imageView
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.standardPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.standardPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.standardPadding),

            articleDetailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.standardPadding/2),
            articleDetailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.standardPadding),
            articleDetailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.standardPadding),
            
            actionButton.topAnchor.constraint(equalTo: articleDetailLabel.bottomAnchor, constant: Constants.standardPadding),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.standardPadding*2),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.standardPadding*2),
            actionButton.heightAnchor.constraint(equalToConstant: 48.0),
            actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.standardPadding)
        ])
    }
    
    private func configureData() {
        titleLabel.text = viewModel?.articleData?.title
        articleDetailLabel.text = viewModel?.articleData?.abstract
        viewModel?.loadImage { imageReturned in
            if let image = imageReturned {
                self.imageView.image = image
             }
        }
    }
    
    // MARK: - Selectors
    
    @objc func didTapReadOnWebsite() {
        if let url = URL(string: viewModel?.articleData?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
