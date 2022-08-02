//
//  HomeTableViewCell.swift
//  NewsApp
//
//  Created by Berkay Sancar on 26.07.2022.
//

import UIKit
import Kingfisher

final class HomeTableViewCell: UITableViewCell {
    
    private let newsImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 10
        return imageview
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    static let identifier: String = "HomeTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - UI CONFIGURE
    private func configure() {
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        newsImageView.layer.cornerRadius = 10
        
        newsImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(newsTitleLabel.snp.left).offset(-5)
        }
        newsTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(newsImageView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(newsImageView.snp.top)
        }
    }
    
    func design(imageURL: String, title: String) {
        
        guard let url = URL(string: imageURL) else { return }
        newsImageView.kf.setImage(with: url)
        newsTitleLabel.text = title
    }
}
