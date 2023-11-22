//
//  AccountSetupView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import SwiftUI

struct AccountSetupView: View {
    @State var username = ""
    var maxLength = 15
    @FocusState var focused:Bool?
    var body: some View {
        VStack{
            VStack(spacing:4){
                Text("Create a username")
                    .foregroundColor(Theme.primaryText)
                    .font(.title)
                    .bold()
            }
            HStack{
                Spacer()
                TextField("",text: $username,prompt:Text("username").foregroundColor(Theme.secondaryText))
                    .font(.system(size:24))
                    .multilineTextAlignment(.center)
                    .frame(height: 40)
                    .onReceive(username.publisher.collect()) {
                        self.username = String($0.prefix(maxLength))
                    }
                    .focused($focused, equals: true)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.focused = true
                        }
                    }
                    .foregroundColor(Theme.primaryText)
                ProgressView()
                    .frame(width: 100) // Adjust width as needed
                Spacer()

            }
            .offset(y:24)
            Spacer()
            Button{
                
            }label:{
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding([.top],64)
        .padding([.horizontal],20)
        .background(Theme.surface1)
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView()
    }
}
