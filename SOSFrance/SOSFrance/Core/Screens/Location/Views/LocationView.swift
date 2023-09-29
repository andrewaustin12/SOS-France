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
                    .font(.title2)
                    .bold()
                Text(viewModel.locationDescription)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    
            }
            .frame(height: 120)
            
        }
        .onAppear {
            // Check for location services and authorization
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
}


#Preview {
    LocationView()
}
