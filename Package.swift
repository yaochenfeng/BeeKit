// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BeeKit",
    products: [
        .library(name: "BeeKit", targets: ["BeeKit"]),
    ],
    targets: [
        .target(name: "BeeKit", path: "Sources/BeeKit/"),
        .testTarget(name: "BeeKitTests",dependencies: ["BeeKit"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
