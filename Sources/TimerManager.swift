import Foundation

enum TimerPhase: String {
    case working = "工作中"
    case breaking = "休息中"
}

@Observable
final class TimerManager {
    let notificationManager: NotificationManager

    private let workDuration = 40 * 60
    private let breakDuration = 10 * 60

    var phase: TimerPhase = .working
    var remainingSeconds: Int = 0
    var isPaused: Bool = false
    var isFlashing: Bool = false
    var showDismissButton: Bool = false

    private var timer: Timer?
    private var flashTimer: Timer?

    init(notificationManager: NotificationManager) {
        self.notificationManager = notificationManager
        self.remainingSeconds = workDuration
    }

    func start() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    func pause() {
        isPaused = true
        stopTimer()
        stopFlashTimer()
    }

    func resume() {
        isPaused = false
        start()
    }

    func skip() {
        stopFlash()
        switchPhase()
        start()
    }

    func togglePause() {
        if isPaused { resume() } else { pause() }
    }

    var formattedTime: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var phaseIcon: String {
        phase == .working ? "🪑" : "🏃"
    }

    private func tick() {
        guard remainingSeconds > 0 else {
            onPhaseEnd()
            return
        }
        remainingSeconds -= 1
    }

    private func onPhaseEnd() {
        stopTimer()
        isFlashing = true
        showDismissButton = true
        notificationManager.notify(phase: phase)
        startFlash()
    }

    private func switchPhase() {
        if phase == .working {
            phase = .breaking
            remainingSeconds = breakDuration
        } else {
            phase = .working
            remainingSeconds = workDuration
        }
    }

    private func startFlash() {
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.isFlashing = !self.isFlashing
        }
        RunLoop.main.add(flashTimer!, forMode: .common)
    }

    private func stopFlashTimer() {
        flashTimer?.invalidate()
        flashTimer = nil
        isFlashing = false
    }

    private func stopFlash() {
        stopFlashTimer()
        showDismissButton = false
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func dismissAndContinue() {
        stopFlash()
        switchPhase()
        start()
    }
}
