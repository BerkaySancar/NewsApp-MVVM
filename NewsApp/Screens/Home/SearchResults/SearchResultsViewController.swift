//
//  SearchResultsViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 25.07.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    
    func SearchResultsViewControllerDidTapNews() // (_ viewModel: DetailViewModel)
    
}

class SearchResultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
