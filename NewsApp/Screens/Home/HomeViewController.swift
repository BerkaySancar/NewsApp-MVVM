//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false // hide background
        searchController.searchBar.placeholder = "Type here to search".localized()
        searchController.searchBar.searchBarStyle = .prominent
        return searchController
    }()
    
    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    
    private let dateTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold)
        textView.backgroundColor = .systemGray5
        textView.textAlignment = .center
        textView.tintColor = .label
        textView.layer.cornerRadius = 10
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    private let formatter = DateFormatter()
    
    private let viewModel: HomeViewModel
    
        init(viewModel: HomeViewModel = HomeViewModel()) {
            
            self.viewModel = viewModel
        
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        viewModel.dataRefreshed = { [weak self] in
            self?.newsTableView.reloadData()
        }
        
        viewModel.dataNotRefreshed = { [weak self] in
            self?.errorMessage(title: "Warning!", message: "News could not found.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.fetchNews()
    }
    
// MARK: - UI Configure
    private func configure() {
        
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = "Home".localized()
        view.backgroundColor = .systemBackground
        
        view.addSubview(newsTableView)
        view.addSubview(dateTextView)
        dateTextView.text = "Filter Date".localized()
        newsTableView.refreshControl = refreshControl
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        
        dateTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(4)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(dateTextView.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
        configureDatePicker()
    }
    private func configureDatePicker() {
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(doneTapped))
        
        toolbar.setItems([doneButton], animated: true)
        
        dateTextView.inputAccessoryView = toolbar
        dateTextView.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
    }
    
    @objc private func doneTapped() {
        formatter.dateStyle = .long
    
        dateTextView.text = formatter.string(from: datePicker.date).localized()
        self.view.endEditing(true)
    }
    
    @objc private func refreshTableView(_ sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.fetchNews()
            self.newsTableView.refreshControl?.endRefreshing()
        }
    }
}
// MARK: - NEWS TABLEViEW
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.newList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                       for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let title = viewModel.newList[indexPath.row].title
        let imageURL = viewModel.newList[indexPath.row].urlToImage
        
        cell.design(imageURL: imageURL ?? "", title: title ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedNews = viewModel.newList[indexPath.row]

        DispatchQueue.main.async { [weak self] in
            let detailsVC = DetailsViewController(selectedNews)
            self?.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
// MARK: - SEARCHCONTROLLER
extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        viewModel.searchNews(searchController.searchBar.text)
    }
}
