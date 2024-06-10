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
    
    @State private var isEditing = false
    @State private var name: String = "Your Name"
    @State private var bloodType: String = "Your Blood Type"
    @State private var allergies: String = "Your Allergies"
    @State private var emergencyContactName: String = "Contact Name"
    @State private var emergencyContactNumber: String = "Contact Number"
    @State private var insuranceCompany: String = "Your Insurance Company"
    @State private var policyNumber: String = "Your Policy Number"
    @State private var contactEmail: String = "Your Contact Email"
    @State private var contactTelephone: String = "Your Contact Telephone"
    @State private var medicalHistory: String = "Your Medical History"
    @State private var currentMedications: String = "Your Current Medications"
    @State private var primaryPhysicianContact: String = "Your Primary Physician Contact"
    @State private var specialInstructions: String = "Your Special Instructions"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    IDCardView(
                        profile: profiles.first ?? EmergencyProfile(
                            name: name,
                            bloodType: bloodType,
                            allergies: allergies,
                            emergencyContactName: emergencyContactName,
                            emergencyContactNumber: emergencyContactNumber,
                            insuranceCompany: insuranceCompany,
                            policyNumber: policyNumber,
                            contactEmail: contactEmail,
                            contactTelephone: contactTelephone,
                            medicalHistory: medicalHistory,
                            currentMedications: currentMedications,
                            primaryPhysicianContact: primaryPhysicianContact,
                            specialInstructions: specialInstructions
                        ),
                        isEditing: $isEditing,
                        name: $name,
                        bloodType: $bloodType,
                        allergies: $allergies,
                        emergencyContactName: $emergencyContactName,
                        emergencyContactNumber: $emergencyContactNumber,
                        insuranceCompany: $insuranceCompany,
                        policyNumber: $policyNumber,
                        contactEmail: $contactEmail,
                        contactTelephone: $contactTelephone,
                        medicalHistory: $medicalHistory,
                        currentMedications: $currentMedications,
                        primaryPhysicianContact: $primaryPhysicianContact,
                        specialInstructions: $specialInstructions
                    )
                }
                .padding()
            }
            .presentPaywallIfNeeded(requiredEntitlementIdentifier: "premium")
            .navigationTitle("Emergency Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditing {
                        Button(action: {
                            saveProfile()
                            isEditing.toggle()
                        }) {
                            Text("Save")
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
                                Text("Edit")
                            }
                            Button(action: {
                                if subscriptionManager.isPremium {
                                    shareProfile()
                                } else {
                                    alertMessage = "Sharing profiles is for premium members only."
                                    showAlert = true
                                }
                            }) {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                        } label: {
                            Label("Options", systemImage: "ellipsis.circle")
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Premium Feature"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
    
    private func saveProfile() {
        let profile = profiles.first ?? EmergencyProfile(
            name: name,
            bloodType: bloodType,
            allergies: allergies,
            emergencyContactName: emergencyContactName,
            emergencyContactNumber: emergencyContactNumber,
            insuranceCompany: insuranceCompany,
            policyNumber: policyNumber,
            contactEmail: contactEmail,
            contactTelephone: contactTelephone,
            medicalHistory: medicalHistory,
            currentMedications: currentMedications,
            primaryPhysicianContact: primaryPhysicianContact,
            specialInstructions: specialInstructions
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

struct IDCardView: View {
    let profile: EmergencyProfile
    @Binding var isEditing: Bool
    @Binding var name: String
    @Binding var bloodType: String
    @Binding var allergies: String
    @Binding var emergencyContactName: String
    @Binding var emergencyContactNumber: String
    @Binding var insuranceCompany: String
    @Binding var policyNumber: String
    @Binding var contactEmail: String
    @Binding var contactTelephone: String
    @Binding var medicalHistory: String
    @Binding var currentMedications: String
    @Binding var primaryPhysicianContact: String
    @Binding var specialInstructions: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            GroupBox(label: Label("Profile Information", systemImage: "person.crop.circle").font(.title2)) {
                VStack(alignment: .leading, spacing: 10) {
                    ProfileRow(title: "Name", value: $name, isEditing: $isEditing)
                    ProfileRow(title: "Blood Type", value: $bloodType, isEditing: $isEditing)
                    ProfileRow(title: "Allergies", value: $allergies, isEditing: $isEditing)
                    ProfileRow(title: "Emergency Contact Name", value: $emergencyContactName, isEditing: $isEditing)
                    ProfileRow(title: "Emergency Contact Number", value: $emergencyContactNumber, isEditing: $isEditing)
                    ProfileRow(title: "Insurance Company", value: $insuranceCompany, isEditing: $isEditing)
                    ProfileRow(title: "Policy Number", value: $policyNumber, isEditing: $isEditing)
                    ProfileRow(title: "Contact Email", value: $contactEmail, isEditing: $isEditing)
                    ProfileRow(title: "Contact Telephone", value: $contactTelephone, isEditing: $isEditing)
                    ProfileRow(title: "Medical History", value: $medicalHistory, isEditing: $isEditing)
                    ProfileRow(title: "Current Medications", value: $currentMedications, isEditing: $isEditing)
                    ProfileRow(title: "Primary Physician Contact", value: $primaryPhysicianContact, isEditing: $isEditing)
                    ProfileRow(title: "Special Instructions", value: $specialInstructions, isEditing: $isEditing)
                }
                .padding(.top, 5)
                .font(.system(size: 18))
            }
        }
        
    }
}

struct ProfileRow: View {
    let title: String
    @Binding var value: String
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title):").bold()
            if isEditing {
                TextEditor(text: $value)
                    .frame(minHeight: 44)  // Adjust the min height as needed
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5))
                    )
            } else {
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct EmergencyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyProfileView()
            .modelContainer(for: EmergencyProfile.self)
            .environmentObject(SubscriptionManager.shared)
    }
}
