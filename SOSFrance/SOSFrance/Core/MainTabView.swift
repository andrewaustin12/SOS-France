//
//  ContentView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NumView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem{
                    Image(systemName: "list.number")
                }.tag(0)
            
            PhrasesView()
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem{
                    Image(systemName: "exclamationmark.bubble.fill")
                }.tag(1)
            
            LocationView()
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem{
                    Image(systemName: "location.circle")
                }.tag(2)
        }
        .splashViewModifier {
          ZStack {
            SplashView()
          }
        }
    }
}

#Preview {
    MainTabView()
}
