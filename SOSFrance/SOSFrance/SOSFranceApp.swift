//
//  SOSFranceApp.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI
import RevenueCat



class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct SOSFranceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
            Purchases.logLevel = .debug
            Purchases.configure(withAPIKey: Secrets.apiKey)
        }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                
        }
    }
}

extension AppDelegate: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        // handle changes to customer info
 
    }
}
