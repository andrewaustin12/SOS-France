//
//  NumView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI
import UIKit
import RevenueCat
import RevenueCatUI

struct NumView: View {
    private let viewModel = NumbersViewModel()
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertDescription = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            VStack{
                Text("Emergency Numbers")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                Text("Numéros D’urgence")
                    .font(.title)
                    .bold()
                    .italic()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
            }
            .background(.blue)
            .frame(maxWidth: .infinity)
        
            ScrollView{
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.numbersList, id: \.self.id) { number in
                        NumberCardView(model: number)
                            
                    }
                }

                .padding(.horizontal)
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertDescription), dismissButton: .cancel())
        })
    }
    
    func Purchased() {
        Purchases.shared.getOfferings { offereings, error in
            if let packages = offereings?.current?.availablePackages {
                Purchases.shared.purchase(package: packages.first!) { transaction, purchaserInfo, error, userCancelled in
                    if error != nil {
                        alertTitle = "PURCHASE FAILED"
                        alertDescription = "Error: \(error!.localizedDescription)"
                        showAlert.toggle()
                    }
                    if purchaserInfo?.entitlements["premium"]?.isActive == true {
                        // success
                        print("✅ Purchase Successfull!")
                        
                        alertTitle = "✅ Purchase Successfull!"
                        alertDescription = "You can now use full features!"
                        showAlert.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    NumView()
}


//VStack{
//    VStack {
//        Text("Emergency Numbers")
//        Text("Numéros D’Urgence")
//    }
//    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//    
//    List{
//        Section {
//            HStack{
//                Text("15")
//                    .font(.title)
//                    
//                Divider()
//                    .bold()
//                VStack{
//                    Text("Services d’Aide Medicale Urgente")
//                    Text("Medical & ambulance service")
//                }
//                .multilineTextAlignment(.leading)
//            }
//            .contentShape(.hoverEffect, Rectangle())
//            .hoverEffect()
//            .onTapGesture {
//                callPhoneNumber(phoneNumber: "15")
//            }
//            .listRowBackground(Color.listBackground)
//        }
//        
//        Section {
//            HStack{
//                Text("17")
//                    .font(.title)
//                Divider()
//                VStack{
//                    Text("La Police Nationale or gendarmerie")
//                    Text("Police")
//                }
//            }
//            .contentShape(.hoverEffect, Rectangle())
//            .hoverEffect()
//            .onTapGesture {
//                callPhoneNumber(phoneNumber: "17")
//            }
//            .listRowBackground(Color.listBackground)
//        }
//        
//        Section {
//            HStack{
//                Text("18")
//                    .font(.title)
//                Divider()
//                VStack {
//                    Text("les Sapeurs Pompiers")
//                    Text("Fire Department / Fire Brigade")
//                }
//            }
//            .contentShape(.hoverEffect, Rectangle())
//            .hoverEffect()
//            .onTapGesture {
//                callPhoneNumber(phoneNumber: "18")
//            }
//            .listRowBackground(Color.listBackground)
//        }
//        
//        Section {
//            HStack{
//                Text("112")
//                    .font(.title)
//                Divider()
//                VStack {
//                    Text("Numéro D’urgence Européen")
//                    Text("European Emergency number")
//                }
//            }
//            .contentShape(.hoverEffect, Rectangle())
//            .hoverEffect()
//            .onTapGesture {
//                callPhoneNumber(phoneNumber: "112")
//            }
//            .listRowBackground(Color.listBackground)
//        }
//        
//        Section{
//            HStack{
//                Text("114")
//                    .font(.title)
//                Divider()
//                VStack {
//                    Text("SMS d’urgence pour sourds et malentendants")
//                    Text("Emergency SMS for deaf & hard of hearing")
//                }
//                
//            }
//            .contentShape(.hoverEffect, Rectangle())
//            .hoverEffect()
//            .onTapGesture {
//                callPhoneNumber(phoneNumber: "114")
//            }
//            .listRowBackground(Color.listBackground)
//        }
//        
//        Section {
//            HStack{
//                Text("115")
//                    .font(.title)
//                Divider()
//                VStack {
//                    Text("Emergency Accomodation")
//                    Text("Hébergement d'urgence")
//                }
//            }
//            .contentShape(.hoverEffect, Rectangle())
//            .hoverEffect()
//            .onTapGesture {
//                callPhoneNumber(phoneNumber: "115")
//            }
//            .listRowBackground(Color.listBackground)
//        }
//        
//    }
//}
//
//}
//func callPhoneNumber(phoneNumber: String) {
//    let phoneURL = URL(string: "tel:\(phoneNumber)")!
//    
//    if UIApplication.shared.canOpenURL(phoneURL) {
//        
//        UIApplication.shared.open(phoneURL, options: [:]) { success in
//            if success {
//                print("The phone app was opened")
//            } else {
//                print("The phone app could not be opened")
//            }
//        }
//    } else {
//        print("The device cannot make phone calls")
//    }
//}
