import SwiftUI
import AVFoundation

struct ListeningLevelView: View {
    let scenario: Scenario
    var onComplete: (() -> Void)? = nil

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
                HStack {
                    Button(action: {
                        stopAudio()
                        presentationMode.wrappedValue.dismiss()
                        onComplete?()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("المستوى \(arabicLevelName(for: scenario.level))")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.white)
                    
                    Text(scenario.title)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .padding(.top,-30)
                
                Spacer()
                    .frame(height: 80)
                
                Button(action: toggleAudio) {
                    Image(isPlaying ? "Open 1" : "replay")
                        .resizable()
                        .frame(width: 180, height: 180)
                        .padding()
                }
                
                if showChoices {
                    Text("ما هو أفضل رد تتوقعه في هذا الموقف؟")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
                
                if showChoices {
                    VStack(spacing: 15) {
                        ForEach(scenario.branches.indices, id: \.self) { index in
                            let item = scenario.branches[index]
                            Button(action: {
                                guard !userHasChosen else { return }
                                userHasChosen = true
                                feedbackText = item.feedback
                                
                                if let audio = item.narratorAudio {
                                    playBranchAudio(named: audio)
                                }
                            }) {
                                ZStack {
                                    Image("Option listen")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 60)
                                        .cornerRadius(12)
                                    HStack {
                                        Spacer()
                                        Text(item.userOption)
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .bold))
                                            .multilineTextAlignment(.trailing)
                                        Spacer(minLength: 50)
                                        Text(optionLetter(for: index))
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .bold))
                                            .padding(.leading, 8)
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            .disabled(userHasChosen)
                            .padding(.horizontal, 30)
                        }
                    }
                } else {
                    Button(action: checkUserInterruption) {
                        ZStack {
                            Image("Interrupt")
                                .resizable()
                                .frame(width: 210, height: 45)
                                .cornerRadius(10)
                            Text("مقاطعة")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                    .padding(.top,28)
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
            }
            
            if userHasChosen, let feedback = feedbackText {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()

                    ZStack(alignment: .topTrailing) {
                        Image("popup")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)

                        VStack(spacing: 15) {
                            Spacer().frame(height: 40)
                            Text("أحسنت!")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)

                            Text(feedback)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)

                            Spacer(minLength: 20)
                        }
                        .frame(width: 300, height: 300)
                        .clipped()

                        Button(action: {
                            userHasChosen = false
                            feedbackText = nil
                            presentationMode.wrappedValue.dismiss()
                            onComplete?()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .padding(10)
                        }
                    }
                }
                .transition(.opacity)
            }

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
            if current > scenario.interruptionRange.upperBound + 2 && !userInterrupted && !showChoices {
                triggerTimeout()
            }
        }
    }
    
    func playAudio(named name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
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
            showBanner(type: .success)
        } else {
            stopAudio()
            playFailSound()
            showBanner(type: .fail)
            restartAudio(after: 2.5)
        }
    }
    
    func restartAudio(after delay: TimeInterval = 2.0) {
        stopAudio()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            playMainAudio()
        }
    }
    
    func triggerTimeout() {
        stopAudio()
        playFailSound()
        showBanner(type: .timeout)
        restartAudio(after: 2.5)
    }
    
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
    
    func optionLetter(for index: Int) -> String {
        switch index {
        case 0: return "أ"
        case 1: return "ب"
        case 2: return "ج"
        default: return ""
        }
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
