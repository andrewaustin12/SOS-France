import SwiftUI

struct NumberCardModel: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let titleFrench: String
    let number: String
    let description: String
    let descriptionFrench: String
    let phoneNumber: String
}


//struct NumberCardModel: Identifiable {
//    let id = UUID().uuidString
//    let icon: String
//    let title: String
//    let number: String
//    let description: String
//    let phoneNumber: String
//}
