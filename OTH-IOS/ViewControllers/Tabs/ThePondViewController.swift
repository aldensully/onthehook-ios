//
//  ThePondViewController.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import UIKit
import SwiftUI

class ThePondViewController: UIViewController {
    
     private var hostingController: UIHostingController<ThePondView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the SwiftUI view
        let swiftUIView = ThePondView()
        hostingController = UIHostingController(rootView: swiftUIView)

        // Add the hosting controller as a child
        if let hostingController = hostingController {
            addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)

            // Set constraints to fill the entire view
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }}
