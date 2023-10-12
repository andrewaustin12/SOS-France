//
//  LocationView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct LocationView: View {
    @ObservedObject var viewModel = LocationViewModel()
    @State private var isPurchased = false
    
    var body: some View {
        NavigationStack {
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
            .blur(radius: isPurchased ? 0 : 10)
            .presentPaywallIfNeeded(requiredEntitlementIdentifier: "premium")
            
        }
        .onAppear {
            // Check to see if user has purchased premium
            checkPurchaseStatus()
            // Check for location services and authorization
            viewModel.checkIfLocationServicesIsEnabled()
            }
        }
    func checkPurchaseStatus() {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let info = customerInfo {
                if info.entitlements["premium"]?.isActive == true {
                    // we are subscribed
                    print("Purchase activce")
                    isPurchased = true
                }
            }
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LocationViewModel() // Create an instance of LocationViewModel
        viewModel.locationDescription = "Your location description for the preview."

        return LocationView(viewModel: viewModel) // Pass the viewModel to LocationView
    }
}


//#Preview {
//    LocationView()
//}
