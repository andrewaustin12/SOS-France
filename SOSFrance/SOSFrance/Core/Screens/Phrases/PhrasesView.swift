import SwiftUI
import RevenueCat
import RevenueCatUI

struct PhrasesView: View {
    @ObservedObject var viewModel = PhrasesViewModel()
    @State private var searchTerm = ""
    @State private var selectedPhrase: HelpPhraseModel?
    @State private var isShowingCardView = false
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    
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
                        .if(subscriptionManager.isPremium) { view in
                            view.onTapGesture {
                                selectedPhrase = helpPhrase
                                isShowingCardView = true
                            }
                        }
                    }
                }
                .blur(radius: subscriptionManager.isPremium ? 0 : 10)
                .presentPaywallIfNeeded(requiredEntitlementIdentifier: "premium")
                .searchable(text: $searchTerm)
                .navigationTitle("Helpful Phrases")
                .disabled(isShowingCardView ? true : false)
                .blur(radius: isShowingCardView ? 20 : 0)
                
                if isShowingCardView {
                    PhrasesCardView(phrase: selectedPhrase!, isShowingDetailView: $isShowingCardView)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3).ignoresSafeArea())
                }
            }
            .onAppear {
                subscriptionManager.restorePurchases()
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
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    PhrasesView()
        .environmentObject(SubscriptionManager.shared)
}
