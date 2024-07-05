// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftConcurrencyEnvironmentKeyTest",
    products: [
        .library(
            name: "SwiftConcurrencyEnvironmentKeyTest",
            targets: ["SwiftConcurrencyEnvironmentKeyTest"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftConcurrencyEnvironmentKeyTest"
        ),
    ]
)
