//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.numberOfLines = 5
        return label
    }()
    
    private let newsTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.showsVerticalScrollIndicator = true
        return textView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.setBackgroundImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: UIControl.State.selected)
        return button
    }()
    
    private var viewModel = DetailsViewModel()
    
    init(_ news: Article) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.setNews(news)
        self.viewModel.getFavorites()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.dataRefreshed = { [weak self] article in
            self?.design(article)
        }
        
        viewModel.dataNotRefreshed = { [weak self] in
            self?.errorMessage(title: "warning", message: "news_could_not_found.")
        }
        
        configure()
    }
// MARK: - UI Configure
    private func configure() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(newsImage)
        view.addSubview(newsTitleLabel)
        view.addSubview(newsTextView)
        view.addSubview(favoriteButton)
        favoriteButton.addTarget(self,
                         action: #selector(favButtonTapped),
                         for: UIControl.Event.touchUpInside)
        
        newsImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-45)
        }
        newsTextView.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(5)
            make.left.equalTo(newsTitleLabel.snp.left)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(newsTitleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-5)
            make.width.height.equalTo(40)
        }
        design(viewModel.news)
    }
    
    private func design(_ article: Article?) {
        
        guard let url = URL(string: article?.urlToImage ?? "") else { return }
        newsImage.kf.setImage(with: url)
        newsTitleLabel.text = article?.title
        newsTextView.text = article?.description
        let item = viewModel.favorites.filter { $0.title == viewModel.news?.title }
        favoriteButton.isSelected = !item.isEmpty
    }
    // MARK: - Favorite Button Action
    @objc private func favButtonTapped(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        let items = viewModel.favorites.filter { $0.title == viewModel.news?.title }
        
        if items.isEmpty {
            viewModel.addFavorites()
        } else {
            let news = viewModel.favorites.filter { $0.title != viewModel.news?.title }
            viewModel.favorites = news
        }
    }
}
