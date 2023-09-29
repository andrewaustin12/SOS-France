//
//  PhrasesViewModel.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import Foundation

class PhrasesViewModel: ObservableObject {
    @Published var helpPhrases: [HelpPhraseModel] = [
        HelpPhraseModel(phraseEnglish: "It’s an emergency: ", phraseFrench: "C’est une urgence." ),
        HelpPhraseModel(phraseEnglish: "My name is…:", phraseFrench: "Je m’appelle…"),
        HelpPhraseModel(phraseEnglish: "My telephone number is…:", phraseFrench: "Mon numéro de téléphone est…"),
        HelpPhraseModel(phraseEnglish: "I live at…:", phraseFrench: "J’habite à…"),
        HelpPhraseModel(phraseEnglish: "Help!:", phraseFrench: "Au secours!"),
        HelpPhraseModel(phraseEnglish: "I need an ambulance!: ", phraseFrench: "J’ai besoin d’une ambulance."),
        HelpPhraseModel(phraseEnglish: "Heart attack:\nEx: My husband had a heart attack.", phraseFrench: "Une crise cardiaque: \nEx: Mon mari fait une crise cardiaque."),
        HelpPhraseModel(phraseEnglish: "Stroke:\nEx: I think my wife suffered a stroke.", phraseFrench: "Une attaque cérébrale:\nEx: Je pense que ma femme a souffert d'une attaque cérébrale."),
        HelpPhraseModel(phraseEnglish: "Choke:\nEx: My baby is choking.", phraseFrench: "S’étouffer: \nEx: Mon bébé s’étouffe."),
        HelpPhraseModel(phraseEnglish: "Difficulty breathing/gasping: \nEx: I have difficulty breathing.", phraseFrench: "Haleter or difficulté à respirer: \nEx: J’ai des difficultés à respirer."),
        HelpPhraseModel(phraseEnglish: "To bleed: \nEx: I am bleeding a lot.", phraseFrench: "Saigner:  \nEx: Je saigne beaucoup."),
        HelpPhraseModel(phraseEnglish: "Hemorrhage: \nEx: My husband had a hemorrhage.", phraseFrench: "Une hémorragie: \nEx: Mon mari fait une hémorragie."),
        HelpPhraseModel(phraseEnglish: "Concussion: \nEx: My child fell. Does he have a concussion?", phraseFrench: "Une commotion cérébrale: \nEx: Mon enfant est tombé. A-t-il une commotion cérébrale?"),
        HelpPhraseModel(phraseEnglish: "Diabetic:\nEx: I need insulin.", phraseFrench: "Diabétique: .\nEx: Je suis diabétique. J’ai besoin d’insuline."),
        HelpPhraseModel(phraseEnglish: "Labor: \nEx: My wife is giving birth. Her water has broken.", phraseFrench:"Accouchement/accoucher: .\nEx: Ma femme accouche; la poche des eaux a percé."),
        HelpPhraseModel(phraseEnglish: "To be poisoned: \nEx: My child has been poisoned.", phraseFrench: "S’empoisonner:\nEx: Mon enfant s’est empoisonné.")
    ]
}

//Police: La Police Nationale or gendarmerie
//Fire brigade: Les sapeurs pompiers
//Emergency services/ambulance: Service d’Aide Médicale d’Urgence or SAMU
//Poisoning emergency: Urgence d’empoisonnement
//Road emergency services: Services d’urgence routière
//Emergency numbers: Numéros d’urgence

