import SwiftUI
import RevenueCat
import RevenueCatUI

struct LocationView: View {
    @ObservedObject var viewModel = LocationViewModel()
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    
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
            .blur(radius: subscriptionManager.isPremium ? 0 : 10)
            .presentPaywallIfNeeded(requiredEntitlementIdentifier: "premium")
        }
        .onAppear {
            subscriptionManager.restorePurchases()
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
}

#Preview {
    let viewModel = LocationViewModel() // Create an instance of LocationViewModel
    viewModel.locationDescription = "Your location description for the preview."
    
    return LocationView(viewModel: viewModel) // Pass the viewModel to LocationView
        .environmentObject(SubscriptionManager.shared)
}
