import SwiftUI
import UIKit
import RevenueCat
import RevenueCatUI

struct NumView: View {
    @StateObject private var viewModel = NumbersViewModel()
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertDescription = ""
    @State private var isFrench = false  // State variable to track language preference

    var body: some View {
        VStack {
            VStack {
                Text(isFrench ? "Numéros D’urgence" : "Emergency Numbers")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                
               
            }
            .padding(.bottom)
            .background(Color.blue)
            .frame(maxWidth: .infinity)
            
            VStack{
                Picker("", selection: $isFrench) {
                    Text("English").tag(false)
                    Text("French").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
        
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.numbersList, id: \.self.id) { number in
                        NumberCardView(model: number, isFrench: $isFrench)
                            .onTapGesture {
                                callPhoneNumber(phoneNumber: number.phoneNumber)
                            }
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 20)
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertDescription), dismissButton: .cancel())
        })
    }
    
    func callPhoneNumber(phoneNumber: String) {
        let phoneURL = URL(string: "tel:\(phoneNumber)")!
        
        if UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:]) { success in
                if success {
                    print("The phone app was opened")
                } else {
                    print("The phone app could not be opened")
                }
            }
        } else {
            print("The device cannot make phone calls")
        }
    }
    
//    func Purchased() {
//        Purchases.shared.getOfferings { offerings, error in
//            if let packages = offerings?.current?.availablePackages {
//                Purchases.shared.purchase(package: packages.first!) { transaction, purchaserInfo, error, userCancelled in
//                    if error != nil {
//                        alertTitle = "PURCHASE FAILED"
//                        alertDescription = "Error: \(error!.localizedDescription)"
//                        showAlert.toggle()
//                    }
//                    if purchaserInfo?.entitlements["premium"]?.isActive == true {
//                        // success
//                        print("✅ Purchase Successful!")
//                        
//                        alertTitle = "✅ Purchase Successful!"
//                        alertDescription = "You can now use full features!"
//                        showAlert.toggle()
//                    }
//                }
//            }
//        }
//    }
}

#Preview {
    NumView()
}
