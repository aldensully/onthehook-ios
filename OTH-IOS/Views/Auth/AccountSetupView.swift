//
//  AccountSetupView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import SwiftUI
import Combine

struct CheckState {
    var valid:Bool
    var checking:Bool
    init(){
        self.valid = false
        self.checking = true
    }
}


struct AccountSetupView: View {
    @State var username = ""
    var maxLength = 15
    @FocusState var focused:Bool?
    @State var usernameCheckState = CheckState()
    @State var publisher = PassthroughSubject<String, Never>()
    var valueChanged: ((_ value: String) -> Void)?
    @State var debounceSeconds = 1.0
    
    func checkUsername (){
        if self.username.lengthOfBytes(using: .utf8) > 0{
            self.usernameCheckState.checking = true
            FirebaseUtility.checkUsernameExists(username) { exists in
                if exists {
                    self.usernameCheckState.valid = false
                }else{
                    self.usernameCheckState.valid = true
                }
                self.usernameCheckState.checking = false
            }
        }
    }
    
    func handleNext(){
        
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(spacing:4){
                    Text("Your username")
                        .foregroundColor(Theme.primaryText)
                        .font(.title)
                        .bold()
                    Text("You can always change it later")
                        .foregroundColor(Theme.primaryText)
                        .font(.callout)
                }
                HStack{
                    Spacer()
                    TextField("",text: $username,prompt:Text("username").foregroundColor(Theme.secondaryText))
                        .font(.system(size:24))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .multilineTextAlignment(.center)
                        .frame(minWidth:100,minHeight: 40)
                        .offset(x:14)
                        .onChange(of: username) { username in
                            publisher.send(username)
                            self.usernameCheckState.checking = true
                        }
                        .onReceive(
                            publisher.debounce(
                                for: .seconds(debounceSeconds),
                                scheduler: DispatchQueue.main
                            )
                        ) { value in
                            checkUsername()
                        }
                        .focused($focused, equals: true)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                self.focused = true
                            }
                        }
                        .foregroundColor(Theme.primaryText)
                    if self.username.lengthOfBytes(using: .utf8) > 0{
                        if self.usernameCheckState.checking {
                            ProgressView()
                                .frame(width: 22)
                        }else if self.usernameCheckState.valid {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green) // Apply red color
                                .font(.system(size: 20))
                        }else{
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red) // Apply red color
                                .font(.system(size: 20))
                        }
                        
                    }else{
                        ProgressView()
                            .frame(width: 22)
                            .opacity(0)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity) // Ensures the HStack fills the view
                .offset(y:24)
                Spacer()
                Button(action: {
                }) {
                    Text("Next")
                        .font(.title2)
                        .foregroundColor(Theme.primaryText)
                        .bold()
                    Image(systemName: "arrow.right")
                        .foregroundColor(Theme.primaryText) // Apply red color
                        .font(.system(size: 20))
                }
                .disabled(self.usernameCheckState.checking || !self.usernameCheckState.valid ||
                          self.username.isEmpty )
                .frame(height: 55) // Set the height but leave the width flexible
                .frame(maxWidth: .infinity) // Fill the whole width
                .background(Theme.primary)
                .clipShape(Capsule())
                .padding([.horizontal],40)
            }
            .frame(width: .infinity, height: .infinity)
            .padding([.top],64)
            .padding([.horizontal],20)
            .background(Theme.surface1)
        }
        
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView()
    }
}
