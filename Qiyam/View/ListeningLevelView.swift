//
//  LevelDetailView.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//


import SwiftUI

struct ListeningLevelView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPlaying = false
    @State private var showAnswers = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 30) {
                // ✅ Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }

                    Spacer()

                    Text("المستوى الأول")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))

                    Spacer()

                    Image(systemName: "chevron.backward")
                        .opacity(0) // توازن
                }
                .padding(.horizontal)

                Spacer()

                // ✅ Play / Pause button with image
                Button(action: {
                    isPlaying.toggle()
                }) {
                    Image(isPlaying ? "Open 1" : "closed")
                        .resizable()
                        .frame(width: 150, height: 150)
                }

                // ✅ مقاطعة أو إجابات
                if !showAnswers {
                    Button(action: {
                        showAnswers = true
                    }) {
                        Text("مقاطعة")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 45)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                } else {
                    VStack(spacing: 15) {
                        ForEach(["الإجابة الأولى", "الإجابة الثانية", "الإجابة الثالثة"], id: \.self) { answer in
                            Button(action: {
                                // اختر ما يحدث بعد اختيار الإجابة
                            }) {
                                Text(answer)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .frame(width: 200, height: 45)
                                    .background(Color("activeblue")) // أو استخدم .blue مباشرة
                                    .cornerRadius(10)
                            }
                        }
                    }
                }

                Spacer()
            }
        }
    }
}

struct LevelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListeningLevelView()
    }
}
