//
//  ProfileView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/21/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        List(){
            Section{
                HStack(spacing:16){
                    Image("qafaha4252")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray, lineWidth: 1))
                    Text(User.TEST_USER.username)
                        .font(.title2)
                        .bold()
                }
            }
            Section("General"){
                    Button{
                        print("Share")
                    } label:{
                        Text("Invite friends")
                            .foregroundColor(.black)
                    }
                    Button{
                        print("Leaving feedback")
                    } label:{
                        Text("Leave feedback")
                            .foregroundColor(.black)
                    }
            }
            Section("Account"){
                    Button{
                        Task{
                            authViewModel.signOut()
                        }
                    } label:{
                        Text("Sign out")
                            .foregroundColor(.red)
                    }
                    Button{
                        Task{
                            authViewModel.deleteAccount()
                        }
                    } label:{
                        Text("Delete account")
                            .foregroundColor(.red)
                    }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
