import SwiftUI
import AVFoundation

struct ListeningLevelView: View {
    let title: String
    let mainAudio: String
    let interruptionRange: ClosedRange<TimeInterval>
    let branches: [ScenarioBranch]?

    @Environment(\.presentationMode) var presentationMode
    @State private var isPlaying = false
    @State private var userInterrupted = false
    @State private var showSuccessBanner = false

    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioTimer: Timer?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 30) {
                // ✅ Header
                HStack {
                    Button(action: {
                        stopAudio()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }

                    Spacer()
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()

                    Image(systemName: "chevron.backward").opacity(0)
                }
                .padding(.horizontal)

                Spacer()

                // ✅ Play / Pause button
                Button(action: toggleAudio) {
                    Image(isPlaying ? "Open 1" : "closed")
                        .resizable()
                        .frame(width: 150, height: 150)
                }

                // ✅ User choices after correct interruption
                if userInterrupted, let branches = branches {
                    VStack(spacing: 15) {
                        ForEach(branches.indices, id: \.self) { index in
                            let item = branches[index]
                            BranchButton(title: item.userOption) {
                                if let audioName = item.narratorAudio {
                                    playBranchAudio(named: audioName)
                                }
                            }
                        }
                    }
                } else {
                    // ✅ Interruption button
                    Button(action: checkUserInterruption) {
                        Text("مقاطعة")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 45)
                            .background(Color(red: 173/255, green: 216/255, blue: 255/255))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                    }
                }

                Spacer()
            }

            // ✅ Success banner
            if showSuccessBanner {
                VStack {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 24))
                            .padding(.leading)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("أحسنت!")
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            Text("قاطعت في اللحظة المناسبة")
                                .foregroundColor(.black.opacity(0.7))
                                .font(.subheadline)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    .padding(.horizontal)
                    .transition(.move(edge: .top).combined(with: .opacity))

                    Spacer()
                }
                .zIndex(1)
            }
        }
        .onAppear(perform: playMainAudio)
        .onDisappear(perform: stopAudio)
    }

    // MARK: - Audio Logic

    func toggleAudio() {
        isPlaying ? stopAudio() : playMainAudio()
    }

    func playMainAudio() {
        playAudio(named: mainAudio)
        userInterrupted = false
        showSuccessBanner = false

        audioTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let current = audioPlayer?.currentTime,
               current > interruptionRange.upperBound,
               !userInterrupted {
                restartAudio()
            }
        }
    }

    func playBranchAudio(named name: String) {
        stopAudio()
        playAudio(named: name)
    }

    func playAudio(named name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("❌ ملف غير موجود: \(name)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("❌ فشل في تشغيل الصوت: \(error)")
        }
    }

    func stopAudio() {
        audioPlayer?.stop()
        audioTimer?.invalidate()
        isPlaying = false
    }

    func restartAudio() {
        stopAudio()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            playMainAudio()
        }
    }

    func checkUserInterruption() {
        guard let current = audioPlayer?.currentTime else { return }

        if interruptionRange.contains(current) {
            userInterrupted = true
            stopAudio()
            showSuccessBanner = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                showSuccessBanner = false
            }
        } else {
            restartAudio()
        }
    }
}

// ✅ الزر
struct BranchButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(red: 173/255, green: 216/255, blue: 255/255))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                .padding(.horizontal, 30)
        }
    }
}

