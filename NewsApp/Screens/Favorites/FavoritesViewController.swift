//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import SafariServices
import UIKit

final class FavoritesViewController: UIViewController {
    
    private let favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    
    private let viewModel: FavoritesViewModel?
    
    init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.dataRefreshed = { [weak self] article in
            self?.viewModel?.favorites = article
            self?.favoritesTableView.reloadData()
        }
        
        viewModel?.dataNotRefreshed = { [weak self] in
            self?.errorMessage(title: "warning", message: "list_is_empty")
        }
        
        configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel?.getFavorites()
        self.favoritesTableView.reloadData()
    }
    
// MARK: - UI Configure
    private func configure() {
        
        view.addSubview(favoritesTableView)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.refreshControl = refreshControl

        navigationController?.navigationBar.topItem?.title = "favorites".localized()
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        
        favoritesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func refreshTableView(_ sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel?.getFavorites()
            self.favoritesTableView.refreshControl?.endRefreshing()
        }
    }
}
// MARK: - FAVORITE TABLE VIEW
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.favorites.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier,
                                                                for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.design(newsTitle: viewModel?.favorites[indexPath.row].title ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel?.favorites.remove(at: indexPath.row)
            self.favoritesTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.viewModel?.getFavorites()
            self.favoritesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: viewModel?.favorites[indexPath.row].url ?? "") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
}
