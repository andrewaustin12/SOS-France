//
//  PhrasesViewModel.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import Foundation

class PhrasesViewModel: ObservableObject {
    @Published var helpPhrases: [HelpPhraseModel] = [
        HelpPhraseModel(phrase: "It’s an emergency: \nC’est un cas d’urgence."),
        HelpPhraseModel(phrase: "My name is…: \nJe m’appelle…"),
        HelpPhraseModel(phrase: "My telephone number is…: \nMon numéro de téléphone est…"),
        HelpPhraseModel(phrase: "I live at…: \nJ’habite à…"),
        HelpPhraseModel(phrase: "Help!: \nAu secours!"),
        HelpPhraseModel(phrase: "I need an ambulance!: \nJ’ai besoin d’une ambulance."),
        HelpPhraseModel(phrase: "Heart attack: \nUne crise cardiaque \n(My husband had a heart attack.) \nMon mari fait une crise cardiaque. "),
        HelpPhraseModel(phrase: "Stroke: \nUne attaque cérébrale \n(I think my wife suffered a stroke.) \nJe pense que ma femme a souffert une attaque cérébrale."),
        HelpPhraseModel(phrase: "Choke: \nS’étouffer \n(My baby is choking.)\nMon bébé s’étouffe."),
        HelpPhraseModel(phrase: "Difficulty breathing/gasping: \nHaleter or difficulté à respirer;\n(I have difficulty breathing.) \nJ’ai difficulté à respirer."),
        HelpPhraseModel(phrase: "To bleed: \nSaigner \n(I am bleeding a lot.) \nJe saigne beaucoup."),
        HelpPhraseModel(phrase: "Hemorrhage: \nUne hémorragie \n(My husband had a hemorrhage.)\nMon mari fait une hémorragie."),
        HelpPhraseModel(phrase: "Concussion: \nUne commotion cérébrale \n(My child fell. Does he have a concussion?)\nMon enfant est tombé. A-t-il une commotion cérébrale?"),
        HelpPhraseModel(phrase: "Diabetic: \nDiabétique \n(I need insulin).\nJe suis diabétique. J’ai besoin d’insuline."),
        HelpPhraseModel(phrase: "Labor: \nAccouchement/accoucher \n(My wife is giving birth. Her water has broken.).\nMa femme accouche; la poche des eaux a percé."),
        HelpPhraseModel(phrase: "To be poisoned: \nS’empoisonner \n(My child has been poisoned.).\nMon enfant s’est empoisonné.")
    ]
}

//Police: La Police Nationale or gendarmerie
//Fire brigade: Les sapeurs pompiers
//Emergency services/ambulance: Service d’Aide Médicale d’Urgence or SAMU
//Poisoning emergency: Urgence d’empoisonnement
//Road emergency services: Services d’urgence routière
//Emergency numbers: Numéros d’urgence

