import SwiftUI

struct BannerView: View {
    enum BannerType {
        case success, fail, timeout

        var iconName: String {
            switch self {
            case .success: return "checkmark"
            case .fail: return "xmark"
            case .timeout: return "clock"
            }
        }

        var circleColor: Color {
            switch self {
            case .success: return .green
            case .fail: return .red
            case .timeout: return .yellow
            }
        }

        var title: String {
            switch self {
            case .success: return "أحسنت !"
            case .fail: return "تسرّعت !"
            case .timeout: return "انتهى الوقت !"
            }
        }

        var subtitle: String {
            switch self {
            case .success: return "قاطعت في اللحظة المناسبة"
            case .fail: return "قاطعت في الوقت الخاطئ"
            case .timeout: return "لم يتم الرد في الوقت المحدد"
            }
        }
    }

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
                    .foregroundColor(.black)

                Text(type.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.top, 12)
    }
}
