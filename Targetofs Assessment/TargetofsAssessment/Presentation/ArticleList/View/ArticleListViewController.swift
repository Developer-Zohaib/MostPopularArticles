//
//  ArticleListViewController.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 18/04/2024.
//

import UIKit

final class ArticleListViewController: UIViewController,
                                       UITableViewDataSource,
                                       UITableViewDelegate,
                                       ArticleListViewModelDelegate {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All Articles", "Recent"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .systemBlue
        return segmentedControl
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        return activityIndicator
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "No data available"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    var coordinator: (any Coordinator)?
    var viewModel: ArticleListViewModel?
    private let cellIdentifier = "ArticleListTableViewCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .primaryBackgroundColor
        
        setupView()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private Methods

    private func setupNavigationBar() {
        title = "Article List"
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primaryLabelColor]
        }
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(segmentedControl)
        view.addSubview(messageLabel)
        view.addSubview(activityIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            messageLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    private func setupViewModel() {
        activityIndicator.startAnimating()
        viewModel?.fetchArticles()
    }

    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Selectors
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        viewModel?.type = sender.selectedSegmentIndex == 0 ? .all : .recent
        self.messageLabel.isHidden = self.viewModel?.getData()?.count == 0  ? false : true
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleListTableViewCell
        guard let rowData = viewModel?.getData()?[indexPath.row]  else {return cell}
        cell.configure(withTitle: rowData.title ?? "", date: rowData.updatedDate?.toDateFormatted() ?? "")
        viewModel?.loadImage(for: indexPath) { imageReturned in
            if let image = imageReturned {
                cell.loadImage(image: image)
             }
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinator = self.coordinator as? HomeCoordinator
        coordinator?.push(to: .articleDetail(viewModel?.getData()?[indexPath.row]))
    }
    
    // MARK: -  ArticleListViewModelDelegate
    
    func didRecieveData() {
        DispatchQueue.main.async {
            self.messageLabel.isHidden = self.viewModel?.getData()?.count == 0  ? false : true
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func didRecieveError(error: Error) {
        showAlert(error.localizedDescription)
    }
}
