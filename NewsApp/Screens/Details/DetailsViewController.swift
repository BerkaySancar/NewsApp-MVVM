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
          return button
      }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
// MARK: - UI Configure
    private func configure() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(newsImage)
        view.addSubview(newsTitleLabel)
        view.addSubview(newsTextView)
        view.addSubview(favoriteButton)
        
        favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        favoriteButton.addTarget(self, action: #selector(favButtonTapped), for: UIControl.Event.touchUpInside)
        
        newsTitleLabel.text = "akjsdhakjs dhalkjh alkshd lkash lkahj a"
        newsTextView.text = "aljksdhlaksjhdlj ahskjdh aksdhakjshd aklsh alksdjh alks dhaklshd"
        
        newsImage.backgroundColor = .gray
        
        newsImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(200)
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
            make.top.equalTo(newsImage.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-5)
            make.width.height.equalTo(40)
        }
    }
    
// MARK: - Favorite Button Action
    @objc func favButtonTapped(_ sender: UIButton) {
        
//        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.setBackgroundImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        } else {
            sender.setBackgroundImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        }
        print("button tapped")
    }
}
