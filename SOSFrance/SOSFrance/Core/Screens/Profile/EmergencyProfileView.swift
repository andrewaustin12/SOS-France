import SwiftUI
import SwiftData
import RevenueCat
import RevenueCatUI

struct EmergencyProfileView: View {
    @Environment(\.modelContext) private var viewContext
    @Query private var profiles: [EmergencyProfile]
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showPaywall = false
    
    @State private var isEditing = false
    @State private var name: String = ""
    @State private var bloodType: String = ""
    @State private var allergies: String = ""
    @State private var emergencyContactName: String = ""
    @State private var emergencyContactNumber: String = ""
    @State private var insuranceCompany: String = ""
    @State private var policyNumber: String = ""
    @State private var contactEmail: String = ""
    @State private var contactTelephone: String = ""
    @State private var medicalHistory: String = ""
    @State private var currentMedications: String = ""
    @State private var primaryPhysicianContact: String = ""
    @State private var specialInstructions: String = ""
    
    var body: some View {
        if #available(iOS 26.0, *) {
            NavigationStack {
                List {
                    // Personal Information Section
                    Section {
                        ProfileRow(title: "Full Name", value: $name, isEditing: $isEditing)
                        BloodTypePickerRow(title: "Blood Type", value: $bloodType, isEditing: $isEditing)
                        ProfileRow(title: "Allergies", value: $allergies, isEditing: $isEditing, isMultiline: true)
                    } header: {
                        Label("Personal Information", systemImage: "person.crop.circle.fill")
                        
                    }
                    
                    // Emergency Contacts Section
                    Section {
                        ProfileRow(title: "Emergency Contact Name", value: $emergencyContactName, isEditing: $isEditing)
                        ProfileRow(title: "Emergency Contact Number", value: $emergencyContactNumber, isEditing: $isEditing, keyboardType: .phonePad)
                        ProfileRow(title: "Primary Physician Contact", value: $primaryPhysicianContact, isEditing: $isEditing)
                    } header: {
                        Label("Emergency Contacts", systemImage: "phone.circle.fill")
                        
                    }
                    
                    // Medical Information Section
                    Section {
                        ProfileRow(title: "Medical History", value: $medicalHistory, isEditing: $isEditing, isMultiline: true)
                        ProfileRow(title: "Current Medications", value: $currentMedications, isEditing: $isEditing, isMultiline: true)
                        ProfileRow(title: "Special Instructions", value: $specialInstructions, isEditing: $isEditing, isMultiline: true)
                    } header: {
                        Label("Medical Information", systemImage: "cross.circle.fill")
                        
                    }
                    
                    // Insurance Information Section
                    Section {
                        ProfileRow(title: "Insurance Company", value: $insuranceCompany, isEditing: $isEditing)
                        ProfileRow(title: "Policy Number", value: $policyNumber, isEditing: $isEditing)
                    } header: {
                        Label("Insurance Information", systemImage: "shield")
                    }
                    
                    // Contact Information Section
                    Section {
                        ProfileRow(title: "Email", value: $contactEmail, isEditing: $isEditing, keyboardType: .emailAddress)
                        ProfileRow(title: "Telephone", value: $contactTelephone, isEditing: $isEditing, keyboardType: .phonePad)
                    } header: {
                        Label("Contact Information", systemImage: "envelope.circle.fill")
                        
                    }
                }
                .blur(radius: subscriptionManager.isPremium ? 0 : 10)
                .presentPaywallIfNeeded(requiredEntitlementIdentifier: "premium")
                .listStyle(.insetGrouped)
                .navigationTitle("Emergency Profile")
                .toolbar {
                    if !subscriptionManager.isPremium {
                        ToolbarItem(placement: .primaryAction){
                            Button(action: {
                                showPaywall.toggle()
                            }) {
                                Image(systemName: "crown.fill")
                                    .foregroundStyle(Color(.yellow))
                                    .fontWeight(.semibold)
                            }
                        }
                        ToolbarSpacer(.fixed, placement: .primaryAction)
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        if isEditing {
                            Button(action: {
                                saveProfile()
                                isEditing.toggle()
                            }) {
                                Text("Save")
                                    .fontWeight(.semibold)
                            }
                        } else {
                            Menu {
                                Button(action: {
                                    if subscriptionManager.isPremium {
                                        isEditing.toggle()
                                    } else {
                                        alertMessage = "Editing profiles is for premium members only."
                                        showAlert = true
                                    }
                                }) {
                                    Label("Edit Profile", systemImage: "pencil")
                                }
                                Button(action: {
                                    if subscriptionManager.isPremium {
                                        shareProfile()
                                    } else {
                                        alertMessage = "Sharing profiles is for premium members only."
                                        showAlert = true
                                    }
                                }) {
                                    Label("Share Profile", systemImage: "square.and.arrow.up")
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                                    .font(.title2)
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Premium Feature"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .sheet(isPresented: $showPaywall) {
                    PaywallView()
                }
            }
            .onAppear {
                if let profile = profiles.first {
                    name = profile.name
                    bloodType = profile.bloodType
                    allergies = profile.allergies
                    emergencyContactName = profile.emergencyContactName
                    emergencyContactNumber = profile.emergencyContactNumber
                    insuranceCompany = profile.insuranceCompany
                    policyNumber = profile.policyNumber
                    contactEmail = profile.contactEmail
                    contactTelephone = profile.contactTelephone
                    medicalHistory = profile.medicalHistory
                    currentMedications = profile.currentMedications
                    primaryPhysicianContact = profile.primaryPhysicianContact
                    specialInstructions = profile.specialInstructions
                }
                
                subscriptionManager.restorePurchases()
            }
        } else {
            NavigationStack {
                List {
                    // Personal Information Section
                    Section {
                        ProfileRow(title: "Full Name", value: $name, isEditing: $isEditing)
                        BloodTypePickerRow(title: "Blood Type", value: $bloodType, isEditing: $isEditing)
                        ProfileRow(title: "Allergies", value: $allergies, isEditing: $isEditing, isMultiline: true)
                    } header: {
                        Label("Personal Information", systemImage: "person.crop.circle.fill")
                        
                    }
                    
                    // Emergency Contacts Section
                    Section {
                        ProfileRow(title: "Emergency Contact Name", value: $emergencyContactName, isEditing: $isEditing)
                        ProfileRow(title: "Emergency Contact Number", value: $emergencyContactNumber, isEditing: $isEditing, keyboardType: .phonePad)
                        ProfileRow(title: "Primary Physician Contact", value: $primaryPhysicianContact, isEditing: $isEditing)
                    } header: {
                        Label("Emergency Contacts", systemImage: "phone.circle.fill")
                        
                    }
                    
                    // Medical Information Section
                    Section {
                        ProfileRow(title: "Medical History", value: $medicalHistory, isEditing: $isEditing, isMultiline: true)
                        ProfileRow(title: "Current Medications", value: $currentMedications, isEditing: $isEditing, isMultiline: true)
                        ProfileRow(title: "Special Instructions", value: $specialInstructions, isEditing: $isEditing, isMultiline: true)
                    } header: {
                        Label("Medical Information", systemImage: "cross.circle.fill")
                        
                    }
                    
                    // Insurance Information Section
                    Section {
                        ProfileRow(title: "Insurance Company", value: $insuranceCompany, isEditing: $isEditing)
                        ProfileRow(title: "Policy Number", value: $policyNumber, isEditing: $isEditing)
                    } header: {
                        Label("Insurance Information", systemImage: "shield")
                    }
                    
                    // Contact Information Section
                    Section {
                        ProfileRow(title: "Email", value: $contactEmail, isEditing: $isEditing, keyboardType: .emailAddress)
                        ProfileRow(title: "Telephone", value: $contactTelephone, isEditing: $isEditing, keyboardType: .phonePad)
                    } header: {
                        Label("Contact Information", systemImage: "envelope.circle.fill")
                        
                    }
                }
                .blur(radius: subscriptionManager.isPremium ? 0 : 10)
                .presentPaywallIfNeeded(requiredEntitlementIdentifier: "premium")
                .listStyle(.insetGrouped)
                .navigationTitle("Emergency Profile")
                .toolbar {
                    if !subscriptionManager.isPremium {
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button(action: {
                                showPaywall.toggle()
                            }) {
                                Image(systemName: "crown.fill")
                                    .fontWeight(.semibold)
                            }
                        }
                        
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if isEditing {
                            Button(action: {
                                saveProfile()
                                isEditing.toggle()
                            }) {
                                Text("Save")
                                    .fontWeight(.semibold)
                            }
                        } else {
                            Menu {
                                Button(action: {
                                    if subscriptionManager.isPremium {
                                        isEditing.toggle()
                                    } else {
                                        alertMessage = "Editing profiles is for premium members only."
                                        showAlert = true
                                    }
                                }) {
                                    Label("Edit Profile", systemImage: "pencil")
                                }
                                Button(action: {
                                    if subscriptionManager.isPremium {
                                        shareProfile()
                                    } else {
                                        alertMessage = "Sharing profiles is for premium members only."
                                        showAlert = true
                                    }
                                }) {
                                    Label("Share Profile", systemImage: "square.and.arrow.up")
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                                    .font(.title2)
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Premium Feature"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .sheet(isPresented: $showPaywall) {
                    PaywallView()
                }
            }
            
            .onAppear {
                if let profile = profiles.first {
                    name = profile.name
                    bloodType = profile.bloodType
                    allergies = profile.allergies
                    emergencyContactName = profile.emergencyContactName
                    emergencyContactNumber = profile.emergencyContactNumber
                    insuranceCompany = profile.insuranceCompany
                    policyNumber = profile.policyNumber
                    contactEmail = profile.contactEmail
                    contactTelephone = profile.contactTelephone
                    medicalHistory = profile.medicalHistory
                    currentMedications = profile.currentMedications
                    primaryPhysicianContact = profile.primaryPhysicianContact
                    specialInstructions = profile.specialInstructions
                }
                
                subscriptionManager.restorePurchases()
            }
        }
    }
    
    private func saveProfile() {
        let profile = profiles.first ?? EmergencyProfile(
            name: "",
            bloodType: "",
            allergies: "",
            emergencyContactName: "",
            emergencyContactNumber: "",
            insuranceCompany: "",
            policyNumber: "",
            contactEmail: "",
            contactTelephone: "",
            medicalHistory: "",
            currentMedications: "",
            primaryPhysicianContact: "",
            specialInstructions: ""
        )
        
        profile.name = name
        profile.bloodType = bloodType
        profile.allergies = allergies
        profile.emergencyContactName = emergencyContactName
        profile.emergencyContactNumber = emergencyContactNumber
        profile.insuranceCompany = insuranceCompany
        profile.policyNumber = policyNumber
        profile.contactEmail = contactEmail
        profile.contactTelephone = contactTelephone
        profile.medicalHistory = medicalHistory
        profile.currentMedications = currentMedications
        profile.primaryPhysicianContact = primaryPhysicianContact
        profile.specialInstructions = specialInstructions
        
        if profile.modelContext == nil {
            viewContext.insert(profile)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save profile: \(error)")
        }
    }
    
    private func shareProfile() {
        let profileInfo = """
        Nom: \(name)
        Groupe sanguin: \(bloodType)
        Allergies: \(allergies)
        Nom du contact d'urgence: \(emergencyContactName)
        Numéro de contact d'urgence: \(emergencyContactNumber)
        Compagnie d'assurance: \(insuranceCompany)
        Numéro de police: \(policyNumber)
        Email de contact: \(contactEmail)
        Téléphone de contact: \(contactTelephone)
        Antécédents médicaux: \(medicalHistory)
        Médicaments actuels: \(currentMedications)
        Contact du médecin traitant: \(primaryPhysicianContact)
        Instructions spéciales: \(specialInstructions)
        """
        
        let activityController = UIActivityViewController(activityItems: [profileInfo], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
        }
    }
}



struct EmergencyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyProfileView()
            .modelContainer(for: EmergencyProfile.self)
            .environmentObject(SubscriptionManager.shared)
    }
}
