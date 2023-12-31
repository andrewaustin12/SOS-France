//
//  PhrasesView.swift
//  SOSFrance
//
//  Created by andrew austin on 9/27/23.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct PhrasesView: View {
    @ObservedObject var viewModel = PhrasesViewModel()
    @State private var searchTerm = ""
    @State private var selectedPhrase: HelpPhraseModel?
    @State private var isShowingCardView = false
    @State private var isPurchased = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(filteredPhrases) { helpPhrase in
                        Section {
                            Text(helpPhrase.phraseEnglish)
                                .font(.title3)
                            Text(helpPhrase.phraseFrench)
                                .italic()
                                .bold()
                        }
                        .listSectionSpacing(5.0)
                        .onTapGesture {
                            selectedPhrase = helpPhrase
                            isShowingCardView = true
                        }
                    }
                }
                .blur(radius: isPurchased ? 0 : 10)
                .presentPaywallIfNeeded(requiredEntitlementIdentifier: "premium")
                .searchable(text: $searchTerm)
                .navigationTitle("Helpful Phrases")
                .disabled(isShowingCardView ? true : false )
                .blur(radius: isShowingCardView ? 20 : 0)
                if isShowingCardView {
                    PhrasesCardView(phrase: selectedPhrase!, isShowingDetailView: $isShowingCardView)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3).ignoresSafeArea())
                }
                
                
            }
            .onAppear {
                checkPurchaseStatus()
            }
            
        }
    }
    
    var filteredPhrases: [HelpPhraseModel] {
        if searchTerm.isEmpty {
            return viewModel.helpPhrases
        } else {
            return viewModel.helpPhrases.filter { helpPhrase in
                helpPhrase.phraseEnglish.localizedCaseInsensitiveContains(searchTerm) ||
                helpPhrase.phraseFrench.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func checkPurchaseStatus() {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let info = customerInfo {
                if info.entitlements["premium"]?.isActive == true {
                    // we are subscribed
                    print("Purchase activce")
                    isPurchased = true
                }
            }
        }
    }
}

#Preview {
    PhrasesView()
}

