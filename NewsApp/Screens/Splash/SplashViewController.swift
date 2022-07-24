//
//  ViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit

final class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .orange
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: { self.present() })
        
    }
    private func present() {
        let vc = MainTabBarViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

