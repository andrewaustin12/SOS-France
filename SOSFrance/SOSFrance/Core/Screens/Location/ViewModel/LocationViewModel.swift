//
//  LocationViewModel.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//


import MapKit


enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
}

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    @Published var locationDescription = ""
    private let geocoder = CLGeocoder()
   
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
            
        } else {
            print("show an alert letting them know this is off and to go turn it on.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location restriction is likely due to parental controls")
            case .denied:
                print("You have denied this app location permission. Go to settings to change it.")
            case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()

        if locationManager?.authorizationStatus == .authorizedWhenInUse || locationManager?.authorizationStatus == .authorizedAlways {
            if let userLocation = locationManager?.location {
                reverseGeocodeLocation(userLocation)
            }
        }
    }

    
    private func reverseGeocodeLocation(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                self.locationDescription = "Location not available"
            } else if let placemark = placemarks?.first {
                // Construct a readable location description from the placemark
                var description = ""
                if let name = placemark.name {
                    description += name + ", "
                }
                if let locality = placemark.locality {
                    description += locality + ", "
                }
                if let administrativeArea = placemark.administrativeArea {
                    description += administrativeArea
                }
                self.locationDescription = description.isEmpty ? "Location not available" : description
            } else {
                self.locationDescription = "Location not available"
            }
        }
    }

}
