import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = LocationViewModel()
    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
        }
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
            // Update the position based on the initial region
            position = .region(viewModel.region)
        }
        .onChange(of: viewModel.region) { newRegion in
            // Update the position whenever the region changes
            position = .region(newRegion)
        }
    }
}

#Preview {
    MapView()
}
