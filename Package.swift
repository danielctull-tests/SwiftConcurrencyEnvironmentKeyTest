// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftConcurrencyEnvironmentKeyTest",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "SwiftConcurrencyEnvironmentKeyTest",
            targets: ["SwiftConcurrencyEnvironmentKeyTest"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftConcurrencyEnvironmentKeyTest",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
    ],
    swiftLanguageVersions: [.v6]
)
