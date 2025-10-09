//import Foundation
//import RevenueCat
//
//class SubscriptionManager: ObservableObject {
//    static let shared = SubscriptionManager()
//    
//    @Published var isPremium: Bool = false
//    
//    private init() {
//        Purchases.shared.getCustomerInfo { (customerInfo, error) in
//            self.isPremium = customerInfo?.entitlements["premium"]?.isActive == true
//        }
//    }
//    
//    func purchasePremium() {
//        Purchases.shared.getOfferings { (offerings, error) in
//            if let package = offerings?.current?.availablePackages.first {
//                Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
//                    if customerInfo?.entitlements["premium"]?.isActive == true {
//                        self.isPremium = true
//                    }
//                }
//            }
//        }
//    }
//    
//    func restorePurchases() {
//        Purchases.shared.restorePurchases { (customerInfo, error) in
//            self.isPremium = customerInfo?.entitlements["premium"]?.isActive == true
//        }
//    }
//}
import Foundation
import Combine
import RevenueCat

class SubscriptionManager: NSObject, ObservableObject {
    @Published var isPremium: Bool = false

    static let shared = SubscriptionManager()

    override init() {
        super.init()
        setupRevenueCatListener()
        checkProStatus()
    }

    func setupRevenueCatListener() {
        Purchases.shared.delegate = self
    }

    func checkProStatus() {
        Purchases.shared.getCustomerInfo { [weak self] (info, error) in
            self?.updatePremiumStatusBasedOn(info: info)
        }
    }

    func updatePremiumStatusBasedOn(info: CustomerInfo?) {
        DispatchQueue.main.async {
            if let entitlements = info?.entitlements, entitlements.all["premium"]?.isActive == true {
                self.isPremium = true
            } else {
                self.isPremium = true // change for testing default is false
            }
        }
    }
    func restorePurchases() {
            Purchases.shared.restorePurchases { [weak self] (info, error) in
                self?.updatePremiumStatusBasedOn(info: info)
            }
        }

}

extension SubscriptionManager: PurchasesDelegate {
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        updatePremiumStatusBasedOn(info: customerInfo)
    }
}
