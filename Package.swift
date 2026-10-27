// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MyNotch",
    platforms: [
        .macOS(.v14) // Target macOS Sonoma (M3 MacBook Air support)
    ],
    targets: [
        .executableTarget(
            name: "MyNotch",
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ],
            linkerSettings: [
                .unsafeFlags([
                    "-Xlinker", "-sectcreate",
                    "-Xlinker", "__TEXT",
                    "-Xlinker", "__info_plist",
                    "-Xlinker", "Info.plist" // Path relative to Package.swift
                ])
            ]
        ),
        .testTarget(
            name: "MyNotchTests",
            dependencies: ["MyNotch"],
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ]
        ),
    ]
)
