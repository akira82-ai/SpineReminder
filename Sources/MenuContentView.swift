import SwiftUI

struct MenuContentView: View {
    let timerManager: TimerManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Flashing dismiss
            if timerManager.isFlashing {
                Button("知道了，开始下一阶段") {
                    timerManager.dismissAndContinue()
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 4)
                Divider()
            }

            // Controls
            Button(timerManager.isPaused ? "▶️ 继续" : "⏸ 暂停") {
                timerManager.togglePause()
            }
            .keyboardShortcut(" ", modifiers: [])

            Button("⏭ 跳过当前阶段") {
                timerManager.skip()
            }
            .keyboardShortcut("n", modifiers: .command)

            Divider()

            Button("退出") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q", modifiers: .command)
        }
        .onAppear {
            timerManager.start()
        }
    }
}
