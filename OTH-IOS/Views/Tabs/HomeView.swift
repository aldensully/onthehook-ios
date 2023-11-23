//
//  HomeView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    @EnvironmentObject var navigator: Navigator
    
    var body: some View {
        Text("Home")
        Button("Navigate to UIKit View") {
//             let uiViewController = LogsViewController() // Initialize your UIKit view controller
//             navigator.navigate(using: uiViewController)
            showModal = true
         }
        .sheet(isPresented: $showModal) {
            LoginView() // Your SwiftUI modal view
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
