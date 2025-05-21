import SwiftUI

struct BannerView: View {
    let type: BannerType

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(type.circleColor)
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: type.iconName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                )

            VStack(alignment: .trailing, spacing: 4) {
                Text(type.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                Text(type.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }

            Spacer()
        }
        .padding()
        .background(Color(hex: "#2C2E2C").opacity(0.8))
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 12)

        .transition(.move(edge: .top).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.3), value: type)
    }
}
