//
//  HelpPhrase.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import Foundation

struct HelpPhraseModel: Identifiable {
    let id = UUID()
    let phraseEnglish: String
    let phraseFrench: String
}
