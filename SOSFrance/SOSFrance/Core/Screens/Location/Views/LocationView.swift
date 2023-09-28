//
//  LocationView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var viewModel = LocationViewModel()
    
    var body: some View {
        VStack {
            MapView()
            
            VStack {
                Text("Your Location")
                Text("24 Rue Saint Germaine" )
                    .padding(.top)
            }
            .frame(height: 100)
            
        }
    }
}

#Preview {
    LocationView()
}
