//
//  MapView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = LocationViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(.pink)
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
    
}

#Preview {
    MapView()
}
