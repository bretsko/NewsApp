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
        let vc = StoryboardScene.Main.homeVC.instantiate()
        vc.coordinator = self // assign vc's coordinator to self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToNewsList(endpoint: EndPoint, vcTitle: String, parameters: [String: String]) {
        let vc = StoryboardScene.Main.articleListVC.instantiate()
        vc.coordinator = self
        vc.title = vcTitle
        vc.endpoint = endpoint // .articles for searching, and .category for category
        NetworkManager.shared.updateParameters(parameters: parameters) // update parameters
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToNewsDetails(article: Article) {
        let vc = StoryboardScene.Main.articleDetailVC.instantiate()
        vc.coordinator = self
        vc.article = article
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func setupNavigationController() {
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.prefersLargeTitles = true
        //        navigationController.navigationBar.tintColor = SettingsService.shared.grayColor //button color
        //        navigationController.setStatusBarColor(backgroundColor: kMAINCOLOR)
    }
}
