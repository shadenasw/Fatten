import SwiftUI

struct ScenarioSelectionSheet: View {
    let level: Int
    let didCompleteText: Bool
    let didCompleteAudio: Bool
    var onSelectText: () -> Void
    var onSelectAudio: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // ✅ العنوان في الأعلى اليمين
            HStack {
                Spacer()
                Text("المستوى \(arabicLevelName(for: level))")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
            }

            // ✅ العنوان السفلي
            Text("اختر نوع السيناريو")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)

            // ✅ الأزرار
            ScenarioButton(
                text: "سيناريو نصي",
                isCompleted: didCompleteText,
                action: onSelectText
            )

            ScenarioButton(
                text: "سيناريو صوت",
                isCompleted: didCompleteAudio,
                action: onSelectAudio
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("sheet").ignoresSafeArea())
    }


    func arabicLevelName(for level: Int) -> String {
        switch level {
        case 1: return "الأول"
        case 2: return "الثاني"
        case 3: return "الثالث"
        case 4: return "الرابع"
        case 5: return "الخامس"
        case 6: return "السادس"
        case 7: return "السابع"
        case 8: return "الثامن"
        case 9: return "التاسع"
        case 10: return "العاشر"
        default: return "\(level)"
        }
    }
}


    struct ScenarioButton: View {
        let text: String
        let isCompleted: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    Image("sheetscenario")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                    
                    HStack {
                        // ✅ الدائرة في أقصى اليسار
                        ZStack {
                            Circle()
                                .strokeBorder(isCompleted ? Color.green : Color.gray, lineWidth: 2)
                                .background(Circle().fill(isCompleted ? Color.green : Color.clear))
                                .frame(width: 37, height: 37)
                            
                            if isCompleted {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                            }
                        }
                        
                        Spacer()
                        
                        // ✅ النص في اليمين
                        Text(text)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .buttonStyle(.plain)
        }
    }

