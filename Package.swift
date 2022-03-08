// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Relativity",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "Relativity",
            targets: ["Relativity"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Relativity",
            dependencies: []),
        .testTarget(
            name: "RelativityTests",
            dependencies: ["Relativity"]),
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
