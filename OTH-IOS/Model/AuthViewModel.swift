//
//  AuthViewModel.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/21/23.
//

import Foundation
import Firebase
import FirebaseAuth
import CryptoKit
import AuthenticationServices

class AuthViewModel:ObservableObject{
    @Published var userSession:FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var nonce = ""
    @Published var needsAccountSetup = false
    @Published var username = ""
    @Published var thumbnail: UIImage?
    static let shared = AuthViewModel()

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                self?.userSession = user
                NotificationCenter.default.post(name: .authStateChanged, object: nil)
            }

            guard let strongSelf = self, let uid = user?.uid else {
                DispatchQueue.main.async {
                    self?.currentUser = nil
                }
                return
            }

            // Call a separate async function
            Task {
                await strongSelf.handleUserAuthentication(withUID: uid)
            }
        }
    }
    
    // Separate async function to handle Firestore operations
    private func handleUserAuthentication(withUID uid: String) async {
        let userRef = Firestore.firestore().collection("users").document(uid)
        let snapshot = try? await userRef.getDocument()

        if let snapshot = snapshot, snapshot.exists,snapshot.documentID == uid {
            DispatchQueue.main.async {
                print("FOUND USER IN DB")
                self.currentUser = try? snapshot.data(as: User.self)
            }
        } else {
            DispatchQueue.main.async {
                print("NEEDS ACCOUNT SETUP")
                self.needsAccountSetup = true
            }
        }
    }

    
    func authenticate(credential:ASAuthorizationAppleIDCredential){
       //getting token
        guard let token = credential.identityToken else {
            print("ERROR WITH FIREBASE AUTH")
            return
        }
        guard let tokenString = String(data:token,encoding:.utf8) else{
            print("ERROR WITH TOKEN")
            return
        }
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString,rawNonce: nonce)
        
        Auth.auth().signIn(with:firebaseCredential){ (result,err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            print("LOGGED IN SUCCESSFULLY")
        }
    }
    
    func signIn() async throws{
        
    }
    
    func createUser() async throws{
        
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }catch{
            print("FAILED TO SIGN OUT")
        }
    }
    
    func deleteAccount(){
        print("Deleting account")
    }
    
    func fetchUser() async{
        
    }
}

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}

func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

extension Notification.Name {
    static let authStateChanged = Notification.Name("AuthStateChangedNotification")
}
