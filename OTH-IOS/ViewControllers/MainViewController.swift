import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObserver()
        updateDisplayedViewController()
    }

    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(authStateChanged), name: .authStateChanged, object: nil)
    }

    @objc private func authStateChanged() {
        updateDisplayedViewController()
    }

    private func updateDisplayedViewController() {
        // Remove existing child view controllers
        children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }

        // Instantiate and add the appropriate view controller
        let childViewController: UIViewController
        if let _ = AuthViewModel.shared.userSession {
            childViewController = TabBarController() // Replace with actual view controller for logged in state
        } else {
            childViewController = SignUpViewController() // Replace with actual view controller for logged out state
        }

        addChild(childViewController)
        childViewController.view.frame = view.bounds
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
