import MapKit

enum MapDetails {
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
}

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MapDetails.defaultSpan)
    @Published var locationDescription = ""
    private let geocoder = CLGeocoder()
    private var lastGeocodeTime: Date?
    private var lastUpdateLocation: CLLocation?
    private var lastKnownAddress: String = "Location not available"
   
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
                    self.checkLocationAuthorization()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn it on.")
            }
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
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let currentTime = Date()
        
        if let lastLocation = lastUpdateLocation {
            let distance = location.distance(from: lastLocation)
            if distance < 10 {
                // Ignore updates if the location hasn't changed significantly
                return
            }
        }
        
        // Throttle updates to once every 5 seconds
        if let lastTime = lastGeocodeTime, currentTime.timeIntervalSince(lastTime) < 5 {
            return
        }
        
        lastGeocodeTime = currentTime
        lastUpdateLocation = location
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
        }
        
        reverseGeocodeLocation(location)
    }
    
    private func reverseGeocodeLocation(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.locationDescription = self.lastKnownAddress
                }
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
                let finalDescription = description.isEmpty ? "Location not available" : description
                DispatchQueue.main.async {
                    self.locationDescription = finalDescription
                    self.lastKnownAddress = finalDescription
                }
            } else {
                DispatchQueue.main.async {
                    self.locationDescription = self.lastKnownAddress
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center.latitude == rhs.center.latitude &&
               lhs.center.longitude == rhs.center.longitude &&
               lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
               lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
}
