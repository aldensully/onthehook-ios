//
//  OTH_IOSApp.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/20/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Buddy", systemImage: "person.2")
                }
            SearchView()
                .tabItem {
                    Label("Logs", systemImage: "book")
                }

            SettingsView()
                .tabItem {
                    Label("The Pond", systemImage: "fish")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct SearchView: View {
    var body: some View {
        Text("Search Screen")
            .navigationBarTitle("Log", displayMode: .inline)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Screen")
            .navigationBarTitle("Explore", displayMode: .inline)
    }
}
