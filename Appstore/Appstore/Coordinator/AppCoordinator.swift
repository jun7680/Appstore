//
//  AppCoordinator.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import UIKit

enum TabbarItem: CaseIterable {
    case search
    
    var values: (vc: UIViewController, title: String, image: UIImage?, tag: Int) {
        switch self {
        case .search:
            return (
                SearchMainViewController(),
                "검색",
                UIImage(systemName: "magnifyingglass"),
                0
            )
        }
    }
}

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    var tabbarController: UITabBarController { get }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var tabbarController: UITabBarController
    init(tabbarController: UITabBarController) {
        self.tabbarController = tabbarController
    }
    
    func start() {
        initTabbarController()
    }
    
}

extension AppCoordinator {
    private func initTabbarController() {
        let viewControllers = TabbarItem.allCases.map {
            buildViewController(with: $0)
        }
        tabbarController.viewControllers = viewControllers
    }
    
    private func buildViewController(with item: TabbarItem) -> UIViewController {
        let tabbarItem = UITabBarItem(
            title: item.values.title,
            image: item.values.image,
            tag: item.values.tag
        )
        
        let viewController = item.values.vc
        let navController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem = tabbarItem
        viewController.title = item.values.title
        navController.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navController.navigationBar.standardAppearance = appearance
        
        return navController
    }
}
