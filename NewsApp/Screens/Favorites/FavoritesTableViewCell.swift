//
//  FavoritesTableViewCell.swift
//  NewsApp
//
//  Created by Berkay Sancar on 26.07.2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        label.textColor = .label
        return label
    }()

    static let identifier: String = "FavoritesTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.addSubview(newsTitleLabel)
        
        newsTitleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
        }
    }
    
    func design(newsTitle: String) {
        
        newsTitleLabel.text = newsTitle
    }
}
