//
//  PhrasesCardView.swift
//  SOSFrance
//
//  Created by andrew austin on 10/1/23.
//

import SwiftUI

struct PhrasesCardView: View {
    
    let phrase: HelpPhraseModel
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        VStack {
            VStack {
                Text(phrase.phraseEnglish)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                
                Text(phrase.phraseFrench)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .italic()
                    .padding()
                    
            }
        }
        .frame(width: 300, height: 550)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button {
            isShowingDetailView = false
        } label: {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                    .opacity(0.6)
                
                Image(systemName: "xmark")
                    .imageScale(.small)
                    .frame(width: 44, height: 44)
                    .foregroundStyle(.black)
            }
        }, alignment: .topTrailing)
    }
}

struct PhrasesCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhrasesCardView(phrase: HelpPhraseModel(phraseEnglish: "Help", phraseFrench: "Aider"), isShowingDetailView: .constant(true))
    }
}


