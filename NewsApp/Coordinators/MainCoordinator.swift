//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationController()
    }
    
    func start() {
        let vc = HomeVC.instantiate() //we can do this because of HomeVC conformed to Storyboarded protocol
        navigationController.pushViewController(vc, animated: false)
    }
    
    fileprivate func setupNavigationController() {
        self.navigationController.isNavigationBarHidden = false
        self.navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = SettingsService.shared.grayColor //button color
        navigationController.setStatusBarColor(backgroundColor: kMAINCOLOR)
    }
}
