//
//  PhrasesView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI

struct PhrasesView: View {
    @ObservedObject var viewModel = PhrasesViewModel()
    
    var body: some View {
        VStack {
            VStack{
                Text("Helpful Phrases")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                   
                Text("Phrases Utiles")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
                    .italic()
                   
            }
            
            List {
                ForEach(viewModel.helpPhrases) { helpPhrase in
                    Section {
                        Text(helpPhrase.phrase)
                            .font(.title3)
                            
                    }.listSectionSpacing(5.0)
                        
                }
            }
        }
        .background(.blue)
    }
}

#Preview {
    PhrasesView()
}

