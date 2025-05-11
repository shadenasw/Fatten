import SwiftUI
import AVFoundation

struct ListeningLevelView: View {
    let scenario: Scenario

    @Environment(\.presentationMode) var presentationMode

    @State private var isPlaying = false
    @State private var showChoices = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioTimer: Timer?
    @State private var userInterrupted = false
    @State private var userHasChosen = false

    @State private var feedbackText: String? = nil
    @State private var feedbackColor: Color = .clear
    @State private var showSuccessBanner = false

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
                    Text("المستوى \(scenario.level)")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()

                    Image(systemName: "chevron.backward").opacity(0)
                }
                .padding(.horizontal)

                Spacer()

                // ✅ Play / Pause Button
                Button(action: toggleAudio) {
                    Image(isPlaying ? "Open 1" : "closed")
                        .resizable()
                        .frame(width: 150, height: 150)
                }

                // ✅ Choices or مقاطعة
                if showChoices {
                    VStack(spacing: 15) {
                        ForEach(scenario.branches.indices, id: \.self) { index in
                            let item = scenario.branches[index]
                            BranchButton(title: item.userOption) {
                                userHasChosen = true
                                feedbackText = item.feedback
                                switch item.feedbackType {
                                case .correct: feedbackColor = .green
                                case .neutral: feedbackColor = .yellow
                                case .incorrect: feedbackColor = .red
                                }

                                if let audio = item.narratorAudio {
                                    playBranchAudio(named: audio)
                                }
                            }
                        }

                        if userHasChosen, let feedback = feedbackText {
                            Text(feedback)
                                .foregroundColor(.white)
                                .padding()
                                .background(feedbackColor)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                .transition(.opacity)
                                .padding(.top)
                        }
                    }
                } else {
                    // ✅ مقاطعة
                    VStack {
                        BranchButton(title: "مقاطعة") {
                            checkUserInterruption()
                        }
                    }
                }

                Spacer()
            }

            // ✅ Banner
            if showSuccessBanner {
                VStack {
                    SuccessBanner()
                    Spacer()
                }
                .zIndex(1)
            }
        }
        .onAppear(perform: playMainAudio)
        .onDisappear(perform: stopAudio)
    }

    // MARK: - الصوت الأساسي

    func toggleAudio() {
        isPlaying ? stopAudio() : playMainAudio()
    }

    func playMainAudio() {
        playAudio(named: scenario.mainAudio)
        userInterrupted = false
        showChoices = false
        userHasChosen = false
        feedbackText = nil

        audioTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            if let current = audioPlayer?.currentTime,
               current > scenario.interruptionRange.upperBound + 1,
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
            print("⚠️ الصوت \(name).mp3 غير موجود")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("❌ خطأ في تشغيل الصوت:", error)
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

    // MARK: - المقاطعة

    func checkUserInterruption() {
        guard let current = audioPlayer?.currentTime else { return }

        let margin: TimeInterval = 1.0
        let lower = scenario.interruptionRange.lowerBound - margin
        let upper = scenario.interruptionRange.upperBound + margin

        if current >= lower && current <= upper {
            userInterrupted = true
            stopAudio()
            showChoices = true

            playSuccessSound()
            triggerHapticFeedback()

            showSuccessBanner = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    showSuccessBanner = false
                }
            }
        } else {
            restartAudio()
        }
    }

    // MARK: - تأثيرات

    func playSuccessSound() {
        guard let path = Bundle.main.path(forResource: "success_ping", ofType: "mp3") else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player.play()
        } catch {
            print("⚠️ ما قدر يشغل صوت النجاح")
        }
    }

    func triggerHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
