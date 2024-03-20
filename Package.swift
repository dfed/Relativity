// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Relativity",
    platforms: [
        .iOS(.v12),
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
    ]
)
