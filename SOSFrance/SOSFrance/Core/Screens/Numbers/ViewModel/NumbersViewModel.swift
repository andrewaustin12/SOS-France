//
//  NumberCardViewModel.swift
//  SOSFrance
//
//  Created by andrew austin on 9/28/23.
//

import Foundation
import SwiftUI

class NumbersViewModel: ObservableObject {
    let numbersList: [NumberCardModel] = [
        NumberCardModel(icon: "cross.case.fill", title: "SAMU", titleFrench: "SAMU", number: "15", description: "Medical Emergency", descriptionFrench: "Urgence Medicale", phoneNumber: "15"),
        NumberCardModel(icon: "shield.fill", title: "Police", titleFrench: "Police", number: "17", description: "Report an Offense", descriptionFrench: "Signal une infraction", phoneNumber: "17"),
        NumberCardModel(icon: "flame.fill", title: "Fire Brigade", titleFrench: "Pompiers", number: "18", description: "Fire Emergency", descriptionFrench: "Situation de peril ou accident", phoneNumber: "18"),
        NumberCardModel(icon: "globe", title: "European Emergency", titleFrench: "Urgence Européenne", number: "112", description: "European Emergency Number", descriptionFrench: "Numéro D’urgence Européen", phoneNumber: "112"),
        NumberCardModel(icon: "message.fill", title: "Emergency SMS", titleFrench: "SMS d’urgence", number: "114", description: "Emergency SMS for Deaf & Hard of Hearing", descriptionFrench: "SMS d’urgence pour sourds et malentendants", phoneNumber: "114")
    ]
}


