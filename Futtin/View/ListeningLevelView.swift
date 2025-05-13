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

    @State private var showSuccessBanner = false
    @State private var showFailBanner = false
    @State private var showTimeoutBanner = false

    @State private var successPlayer: AVAudioPlayer?
    @State private var failPlayer: AVAudioPlayer?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 30) {
                // Header
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

                // Play / Pause
                Button(action: toggleAudio) {
                    Image(isPlaying ? "Open 1" : "closed")
                        .resizable()
                        .frame(width: 150, height: 150)
                }

                // Choices or Interruption
                if showChoices {
                    VStack(spacing: 15) {
                        ForEach(scenario.branches.indices, id: \.self) { index in
                            let item = scenario.branches[index]
                            BranchButton(title: item.userOption) {
                                guard !userHasChosen else { return }
                                userHasChosen = true
                                feedbackText = item.feedback

                                if let audio = item.narratorAudio {
                                    playBranchAudio(named: audio)
                                }
                            }
                            .disabled(userHasChosen)
                        }
                    }
                } else {
                    BranchButton(title: "مقاطعة") {
                        checkUserInterruption()
                    }
                }

                Spacer()
            }

            // Feedback Popup
            // Feedback Popup
            if userHasChosen, let feedback = feedbackText {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            Button(action: {
                                userHasChosen = false
                                feedbackText = nil
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        }

                        Text("أحسنت!")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)

                        Text(feedback)
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)

                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: 300, minHeight: 150)
                    .background(Color(red: 97/255, green: 201/255, blue: 245/255))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                }
                .transition(.opacity)
            }

            // Banners (top-aligned)
            VStack {
                if showSuccessBanner {
                    BannerView(type: .success)
                } else if showFailBanner {
                    BannerView(type: .fail)
                } else if showTimeoutBanner {
                    BannerView(type: .timeout)
                }

                Spacer()
            }
            .zIndex(2)
            .transition(.move(edge: .top).combined(with: .opacity))
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
            guard let current = audioPlayer?.currentTime else { return }

            if current > scenario.interruptionRange.upperBound + 1 && !userInterrupted && !showChoices {
                triggerTimeout()
            }
        }
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

    func playBranchAudio(named name: String) {
        stopAudio()
        playAudio(named: name)
    }

    func stopAudio() {
        audioPlayer?.stop()
        audioTimer?.invalidate()
        isPlaying = false
    }

    func restartAudio(after delay: TimeInterval = 2.0) {
        stopAudio()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
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
            // ✅ صح
            userInterrupted = true
            stopAudio()
            showChoices = true
            playSuccessSound()
            triggerHapticFeedback()
            showBanner(type: .success)
        } else {
            // ❌ خطأ
            stopAudio()
            playFailSound()
            showBanner(type: .fail)
            restartAudio(after: 2.5)
        }
    }

    func triggerTimeout() {
        stopAudio()
        playFailSound()
        showBanner(type: .timeout)
        restartAudio(after: 2.5)
    }

    // MARK: - تأثيرات

    func playSuccessSound() {
        playSound(named: "success_ping", player: &successPlayer)
    }

    func playFailSound() {
        playSound(named: "fail_ping", player: &failPlayer)
    }

    func playSound(named name: String, player: inout AVAudioPlayer?) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
        } catch {
            print("❌ خطأ في الصوت \(name):", error)
        }
    }

    func triggerHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    func showBanner(type: BannerType) {
        switch type {
        case .success: showSuccessBanner = true
        case .fail: showFailBanner = true
        case .timeout: showTimeoutBanner = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                showSuccessBanner = false
                showFailBanner = false
                showTimeoutBanner = false
            }
        }
    }
}
