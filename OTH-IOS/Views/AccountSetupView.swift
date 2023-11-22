//
//  AccountSetupView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import SwiftUI

struct AccountSetupView: View {
    var body: some View {
        VStack{
            Text("Set up your account")
                .foregroundColor(.black)
                .font(.title3)
        }
        .background(.white)
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView()
    }
}
