//
//  NumberCardViewModel.swift
//  SOSFrance
//
//  Created by andrew austin on 9/28/23.
//

import Foundation

struct NumberCardModel: Identifiable {
    let id = UUID().uuidString
    let icon: String
    let title: String
    let number: String
    let description: String
    let phoneNumber: String
}

struct NumbersViewModel {
    
    let numbersList: [NumberCardModel] =
    
    [
    
        NumberCardModel(icon: "cross.case", title: "SAMU", number: "15", description: "Urgence \nMedicale", phoneNumber: "15"),
        NumberCardModel(icon: "shield", title: "Police", number: "17", description: "Signal une infraction", phoneNumber: "17"),
        NumberCardModel(icon: "flame", title: "Pompiere", number: "18", description: "Situation de peril ou accident", phoneNumber: "18"),
        NumberCardModel(icon: "teletype.answer", title: "Urgence SMS", number: "114", description: "SMS d’urgence pour sourds et malentendants", phoneNumber: "114"),
        NumberCardModel(icon: "globe.europe.africa", title: "Europe", number: "112", description: "Numéro D’urgence Européen", phoneNumber: "112"),
        
    
    ]
}

