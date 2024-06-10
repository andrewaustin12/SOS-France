import SwiftUI

struct NumberCardView: View {
    let model: NumberCardModel
    @Binding var isFrench: Bool  // Binding to track language preference

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Circle()
                    .fill(Color("cardFont"))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: model.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("iconFill"))
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(isFrench ? model.titleFrench : model.title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("phoneFill"))
                        Text(model.number)
                            .font(.title2)
                            .foregroundColor(Color("cardFont"))
                            .bold()
                    }
                    
                    Text(isFrench ? model.descriptionFrench : model.description)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
            .background(Color("cardBackground"))
            .cornerRadius(15)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NumberCardView(model: NumberCardModel(icon: "cross.case.fill", title: "SAMU", titleFrench: "SAMU", number: "15", description: "Medical Emergency", descriptionFrench: "Urgence Medicale", phoneNumber: "15"), isFrench: .constant(false))
}
