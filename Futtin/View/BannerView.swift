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
        .background(
            Color(hex: "#2C2E2C")
                .opacity(0.85)
                .background(.ultraThinMaterial)
        )
 // ✨ يعطيك تأثير زجاجي مودرن
        .cornerRadius(24) // حواف ناعمة أكثر
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 5) // ظل واضح
        .padding(.horizontal, 16)
        .padding(.top, 20) // تنزله شوي من أعلى الشاشة
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}
