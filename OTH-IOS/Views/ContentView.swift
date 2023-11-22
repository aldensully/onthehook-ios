//
//  ContentView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Group{
            if authViewModel.userSession != nil && authViewModel.currentUser != nil {
                MainTabView()
            }else if authViewModel.needsAccountSetup {
                AccountSetupView()
            }
            else{
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
