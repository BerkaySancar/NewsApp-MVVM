//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit
import Alamofire

final class HomeViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.obscuresBackgroundDuringPresentation = false // hide background
        search.searchBar.placeholder = "Type here to search".localized()
        search.searchBar.searchBarStyle = .prominent
        return search
    }()
    
    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()
    
    private let viewModel: HomeViewModel
    
        init(viewModel: HomeViewModel = HomeViewModel()) {
            
            self.viewModel = viewModel
        
            super.init(nibName: nil, bundle: nil)
            
            self.viewModel.delegate = self
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchData()
    }
    
// MARK: - UI Configure
    private func configure() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(newsTableView)
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = "Home".localized()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        let vc = DetailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - HOME VIEW MODEL DELEGATE
extension HomeViewController: HomeViewModelDelegate {
    
    func dataRefreshed() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
}
// MARK: - SEARCHCONTROLLER
extension HomeViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text,
                   text.trimmingCharacters(in: CharacterSet.whitespaces).count >= 2  else { return }
             
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
    }
    
    func SearchResultsViewControllerDidTapNews() {
        
        let berkay = "berkay"
    }
}

