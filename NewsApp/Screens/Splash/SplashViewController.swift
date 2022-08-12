//
//  ViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit
import UserNotifications

final class SplashViewController: UIViewController {
    
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "newspaper")
        imageView.image = image
        imageView.tintColor = .label
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .label
        label.text = "news_app".localized()
        return label
    }()
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        registerForRemoteNotification()
    }
// MARK: - UI Configure
    private func configure() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(appLogoImageView)
        view.addSubview(appNameLabel)
        
        appLogoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerY.centerX.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appLogoImageView.snp.bottom).offset(10)
            make.centerX.equalTo(appLogoImageView)
        }
    }

// MARK: - Push Notification
    private func registerForRemoteNotification() {

        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()

            center.requestAuthorization(options: [.sound, .alert, .badge]) { _, error in

                if error == nil {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.present()
                    }
                }
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(
                types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    private func present() {
        let mainTabBarVC = MainTabBarViewController()
        mainTabBarVC.modalTransitionStyle = .crossDissolve
        mainTabBarVC.modalPresentationStyle = .fullScreen
        present(mainTabBarVC, animated: false)
    }
}
