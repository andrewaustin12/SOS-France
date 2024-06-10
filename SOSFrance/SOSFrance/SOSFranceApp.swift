import SwiftUI
import RevenueCat
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct SOSFranceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var subscriptionManager = SubscriptionManager.shared
    let container: ModelContainer
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Secrets.apiKey)
        
        let schema = Schema([EmergencyProfile.self])
        let config = ModelConfiguration("SOSFrance", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not configure the container: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modelContainer(container)
                .environmentObject(subscriptionManager)
        }
    }
}

extension AppDelegate: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        // handle changes to customer info
    }
}
