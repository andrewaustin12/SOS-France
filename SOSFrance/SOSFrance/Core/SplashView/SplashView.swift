//
//  SplashView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack{
                Image(systemName: "sos")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 200,height: 100)
                Text("FRANCE")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red)

            }
        }
        
    }
}

#Preview {
    SplashView()
}
