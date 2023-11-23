//
//  TabsViewController.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import UIKit

class Navigator: ObservableObject {
    // Closure that can be set by UIKit to handle navigation
    var navigateToViewController: ((UIViewController) -> Void)?

    // Method called by SwiftUI to navigate
    func navigate(using viewController: UIViewController) {
        navigateToViewController?(viewController)
    }
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize child view controllers
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        let secondViewController = LogsViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let thirdViewController = ThePondViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        // Add child view controllers to the tab bar
        viewControllers = [firstViewController, secondViewController,thirdViewController]
    }
}
