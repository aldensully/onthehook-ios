//
//  HomeViewController.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    var hostingController: UIHostingController<AnyView>?

    
        let navigator = Navigator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swiftUIView = AnyView(HomeView().environmentObject(navigator))
        hostingController = UIHostingController(rootView: swiftUIView)

        // Now add the hosting controller as a child view controller
        if let hostingController = hostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }
}
