//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Home".localized()
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
