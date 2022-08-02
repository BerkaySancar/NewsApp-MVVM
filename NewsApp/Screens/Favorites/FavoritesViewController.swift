//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private let favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       configure()
    }
    
// MARK: - UI Configure
    private func configure() {
        
        view.addSubview(favoritesTableView)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.title = "Favorites".localized()
        
        favoritesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
// MARK: - FAVORITE TABLE VIEW
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier,
                                                                for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.design(newsTitle: "berkay")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
