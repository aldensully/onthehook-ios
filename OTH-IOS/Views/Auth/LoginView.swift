//
//  LoginView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/21/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack(spacing:64){
                Spacer()
                SignInWithAppleButton { (request) in
                    authViewModel.nonce = randomNonceString()
                    request.requestedScopes = [.email,.fullName]
                    request.nonce = sha256(authViewModel.nonce)
                } onCompletion : { (result) in
                    switch result{
                    case .success(let user):
                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                            print("ERROR WITH FIREBASE AUTH")
                            return
                        }
                        authViewModel.authenticate(credential: credential)
                        print("SUCCESSFULLY SIGNED IN WITH APPLE")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .signInWithAppleButtonStyle(.black)
                .frame(height:55)
                .clipShape(Capsule())
                .padding(.horizontal,20)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
