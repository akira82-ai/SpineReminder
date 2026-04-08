// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SpineReminder",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(
            name: "SpineReminder",
            path: "Sources"
        )
    ]
)
