//
//  LV.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//
import SwiftUI

struct ActiveListeningView: View {
    let completedLevels: [Int] = [1] // مثال: أنجز فقط لفل 1

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach((1...10).reversed(), id: \.self) { level in
                        VStack(spacing: 4) {
                            if level != 10 {
                                // أول خط صغير
                                Image(lineImageName(for: level + 1))
                                    .resizable()
                                    .frame(width: 6, height: 28)

                                // ثاني خط صغير
                                Image(lineImageName(for: level + 1))
                                    .resizable()
                                    .frame(width: 6, height: 28)
                            }

                            // الدائرة
                            Image(completedLevels.contains(level) ? "circlelevel" : "greylevel")
                                .resizable()
                                .frame(width: 80, height: 80) // ← كبرنا الدائرة
                                .overlay(
                                    Text(arabicNumber(level))
                                        .foregroundColor(.white)
                                        .font(.system(size: 40, weight: .bold))
                                )
                        }
                    }
                }
                .padding(.bottom, 50)
                .frame(maxWidth: .infinity)
            }
        }
    }

    // تعيين اسم صورة الخط حسب حالة الإنجاز
    func lineImageName(for level: Int) -> String {
        completedLevels.contains(level) ? "bluelevel" : "soundlevel"
    }

    // تحويل الأرقام إلى العربية
    func arabicNumber(_ num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")
        return formatter.string(from: NSNumber(value: num)) ?? "\(num)"
    }
}

struct ActiveListening_Previews: PreviewProvider {
    static var previews: some View {
        ActiveListeningView()
    }
}
