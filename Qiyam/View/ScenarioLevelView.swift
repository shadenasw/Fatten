//
//  ScenarioDetailView.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//
import SwiftUI

struct ScenarioLevelView: View {
    let scenario: TextScenarios
    @State private var selectedChoiceIndex: Int? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .padding(.leading)
                Spacer()
            }
            
            Text("المستوى \(scenario.level)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, -30)
            
            // ✅ Scenario Box with custom background image
            ZStack {
                Image("scenario_box")
                    .resizable()
                    .scaledToFit()
                Text(scenario.description)
                    .multilineTextAlignment(.center)
                    .padding(30)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
            // Image (ثابتة - ما تتغير)
            Image("meeting_illustration")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.horizontal)
            
            // Options - شكل ثابت زي الصورة
            VStack(spacing: 15) {
                ForEach(Array(scenario.choices.enumerated()), id: \.offset) { index, choice in
                    FixedOptionButton(
                        text: choice.text,
                        label: optionLetter(for: index)
                    ) {
                        selectedChoiceIndex = index
                        // ما نسوي أي شي ثاني (لأنك ما تبي تطلع النقاط)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
    }
    
    func optionLetter(for index: Int) -> String {
        switch index {
        case 0: return "أ"
        case 1: return "ب"
        case 2: return "ج"
        default: return ""
        }
    }
}

// ✅ Custom button with fixed design (زي اللي بالصورة)
struct FixedOptionButton: View {
    let text: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // ✅ خلفية الصورة (Option)
                Image("Option")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 110) // تقدر تتحكم في الارتفاع لو حبيت
                
                HStack {
                    Spacer()
                    
                    Text(text)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4) // ✅ مسافة بين السطور
                        .padding(.horizontal, 12) // ✅ يوازن المسافة يمين ويسار
                        .padding(.vertical, 8)    // ✅ يضيف تهوية فوق وتحت
                        .fixedSize(horizontal: false, vertical: true) // ✅ يخليه يلف طبيعي
                        .padding(.trailing, 75)
                }
                    Text(label)
                        .font(.system(size: 18, weight: .bold)) // شوي أكبر عشان الصورة كبرت
                        .frame(width: 36, height: 36) // أكبر شوي مع كبر الصورة
                        .foregroundColor(.black)
                        .padding(.leading, 300)


                }
            }
            .frame(height: 60) // نفس ارتفاع الصورة عشان يثبت الشكل
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }


#Preview {
    ScenarioLevelView(scenario: scenarios[0])
        .environment(\.layoutDirection, .rightToLeft)
}
