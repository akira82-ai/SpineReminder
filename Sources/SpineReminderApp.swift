import SwiftUI

@main
struct SpineReminderApp: App {
    @State private var notificationManager = NotificationManager()
    @State private var timerManager: TimerManager

    init() {
        let nm = NotificationManager()
        let tm = TimerManager(notificationManager: nm)
        _notificationManager = State(initialValue: nm)
        _timerManager = State(initialValue: tm)
    }

    var body: some Scene {
        MenuBarExtra {
            MenuContentView(timerManager: timerManager)
        } label: {
            Text("\(timerManager.phaseIcon) \(timerManager.formattedTime)")
        }
    }
}
