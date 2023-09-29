//
//  Num2View.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI

struct NumberCardView: View {
    let model: NumberCardModel
    
    var body: some View {
        VStack{
            Text(model.title)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .padding(.top)
                .fixedSize(horizontal: false, vertical: true)

            ZStack{
                Circle()
                    .fill(.cardFont)
                    .frame(width: 100, height: 60)
                Image(systemName: model.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.iconFill)
                
            }
            
            HStack {
                Image(systemName: "phone.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.phoneFill)
                Text(model.number)
                    .font(.title)
                    .foregroundStyle(.cardFont)
                    .bold()
            }
            
            Text(model.description)
                .font(.headline)
                .foregroundStyle(.white)
                .bold()
                .padding(.bottom)
                .padding(.leading)
                .padding(.trailing)
                .fixedSize(horizontal: false, vertical: true)
        }
        .clipShape(.rect())
        .frame(width: 170, height: 300)
        .background(.cardBackground)
        .cornerRadius(20)
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(.gray, lineWidth: 2)
        )
        .onTapGesture {
            callPhoneNumber(phoneNumber: model.phoneNumber)
        }
            
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
}

#Preview {
    NumberCardView(model: NumberCardModel(icon: "cross.case", title: "SAMU", number: "15", description: "Urgence Medicale", phoneNumber: "15"))
}


