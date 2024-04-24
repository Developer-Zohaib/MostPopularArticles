//
//  ArticleListTableViewCell.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 18/04/2024.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        // label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .primaryLabelColor
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.font = UIFont.systemFont(ofSize: 16)
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.standardPadding
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let  stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.standardPadding
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.standardPadding
        
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        do {
            addSubview(containerView)
            do {
                containerView.addSubview(labelsStackView)
                do {
                    labelsStackView.addArrangedSubview(titleLabel)
                    labelsStackView.addArrangedSubview(dateLabel)
                }
                
                containerView.addSubview(articleImageView)
            }
        }
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.standardPadding/2),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.standardPadding),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.standardPadding),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.standardPadding/2),
            
            articleImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.standardPadding),
            articleImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.standardPadding),
            articleImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.standardPadding),
            articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor, multiplier: 1.15),
            articleImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.35),
            
            labelsStackView.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.standardPadding),
            labelsStackView.trailingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: -Constants.standardPadding),
            labelsStackView.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 26.0)
        ])
        
        self.selectionStyle = .none
        self.accessibilityIdentifier = AccessibilityIdentifier.articleCell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Add shadow
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
          super.traitCollectionDidChange(previousTraitCollection)
          
          // Check if the user interface style changed
          if #available(iOS 13.0, *) {
              if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                  // User interface style changed
                  updateUIForCurrentInterfaceStyle()
              }
          }
      }
    
    func updateUIForCurrentInterfaceStyle() {
          if traitCollection.userInterfaceStyle == .dark {
              DispatchQueue.main.async {
                  self.containerView.layer.borderColor = UIColor.white.cgColor
                  self.containerView.layer.borderWidth = 1
              }
          } else {
              DispatchQueue.main.async {
                  self.containerView.layer.borderColor = UIColor.lightGray.cgColor
                  self.containerView.layer.borderWidth = 1
              }
          }
      }
    
    // MARK: - Public Methods
    
    func configure(withTitle title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }
    
    func loadImage(image: UIImage) {
        articleImageView.image = image
    }
    
    // MARK: - Inner Types
    
    private enum Constants {
        static let standardPadding = 16.0
    }
}
