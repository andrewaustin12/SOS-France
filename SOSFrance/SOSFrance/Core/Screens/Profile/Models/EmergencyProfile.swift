import Foundation
import SwiftData

@Model
class EmergencyProfile: Identifiable {
    var id = UUID()
    var name: String
    var bloodType: String
    var allergies: String
    var emergencyContactName: String
    var emergencyContactNumber: String
    var insuranceCompany: String
    var policyNumber: String
    var contactEmail: String
    var contactTelephone: String
    var medicalHistory: String
    var currentMedications: String
    var primaryPhysicianContact: String
    var specialInstructions: String
    
    init(id: UUID = UUID(), name: String, bloodType: String, allergies: String, emergencyContactName: String, emergencyContactNumber: String, insuranceCompany: String, policyNumber: String, contactEmail: String, contactTelephone: String, medicalHistory: String, currentMedications: String, primaryPhysicianContact: String, specialInstructions: String) {
        self.id = id
        self.name = name
        self.bloodType = bloodType
        self.allergies = allergies
        self.emergencyContactName = emergencyContactName
        self.emergencyContactNumber = emergencyContactNumber
        self.insuranceCompany = insuranceCompany
        self.policyNumber = policyNumber
        self.contactEmail = contactEmail
        self.contactTelephone = contactTelephone
        self.medicalHistory = medicalHistory
        self.currentMedications = currentMedications
        self.primaryPhysicianContact = primaryPhysicianContact
        self.specialInstructions = specialInstructions
    }
}
