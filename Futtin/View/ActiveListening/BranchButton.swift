import SwiftUI

struct BranchButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Image("Interrupt")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 280, height: 60)
                    .cornerRadius(10)
                
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
        }
        .buttonStyle(PlainButtonStyle()) // يمنع أي تأثير افتراضي من SwiftUI على الزر
    }
}
