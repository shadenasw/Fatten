import SwiftUI

struct ProgressViewScreen: View {
    @ObservedObject var progressVM: ProgressViewModel

    let voiceColor = Color(red: 50/255, green: 139/255, blue: 177/255)
    let workColor = Color(red: 251/255, green: 185/255, blue: 45/255)
    let backgroundColor = Color(red: 35/255, green: 36/255, blue: 35/255)

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack(spacing: 40) {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 6) {
                        Text("مرحباً 👋")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)

                        Text("تتبع تقدمك في الذكاء العاطفي")
                            .font(.system(size: 18))
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
                .padding(.horizontal)

                ZStack {
                    Circle()
                        .stroke(voiceColor.opacity(0.2), lineWidth: 16)
                        .frame(width: 200, height: 200)

                    Circle()
                        .trim(from: 0, to: 1.0)
                        .stroke(voiceColor, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))

                    Circle()
                        .stroke(workColor.opacity(0.2), lineWidth: 10)
                        .frame(width: 170, height: 170)

                    Circle()
                        .trim(from: 0, to: progressVM.progress)
                        .stroke(workColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 170, height: 170)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeOut(duration: 0.6), value: progressVM.progress)

                    Text("\(Int(progressVM.progress * 100))%")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                }

                VStack(spacing: 20) {
                    HStack {
                        Text("\(Int(progressVM.progress * 100))%")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)

                        Spacer()

                        HStack(spacing: 8) {
                            Text("سيناريو العمل💼")
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .background(workColor.opacity(0.85))
                    .cornerRadius(14)
                    .frame(maxWidth: 300)

                    HStack {
                        Text("100%")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)

                        Spacer()

                        HStack(spacing: 8) {
                            Text("سيناريو الصوت🔈")
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                    .background(voiceColor.opacity(0.85))
                    .cornerRadius(14)
                    .frame(maxWidth: 300)
                }

                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
    }
}
