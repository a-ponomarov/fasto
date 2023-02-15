// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "TimeCircleView",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "TimeCircleView",
            targets: ["TimeCircleView"])
    ],
    targets: [
        .target(
            name: "TimeCircleView",
            dependencies: [])
    ]
)
