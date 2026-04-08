import AppKit
import Foundation
import UserNotifications

final class NotificationManager {
    private let center = UNUserNotificationCenter.current()

    init() {
        requestPermission()
    }

    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error {
                print("Notification permission error: \(error)")
            }
        }
    }

    func notify(phase: TimerPhase) {
        let title: String
        let body: String
        let sound: String

        switch phase {
        case .working:
            title = "工作时间结束"
            body = "站起来活动一下吧！放松腰部，做做拉伸。"
            sound = "Glass"
        case .breaking:
            title = "休息时间结束"
            body = "该坐下来继续工作了，记得保持良好坐姿。"
            sound = "Ping"
        }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound(named: .init(sound))

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        center.add(request)
    }

    func playAlertSound(name: String) {
        NSSound(named: name)?.play()
    }
}
