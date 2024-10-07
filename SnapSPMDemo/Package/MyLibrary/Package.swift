// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyLibrary",
    defaultLocalization: "en", platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MyLibrary",
            targets: ["MyLibrary"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(name: "SCSDKCameraKit", path: "./Frameworks/SCSDKCameraKit.xcframework"),
        .binaryTarget(name: "SCSDKCoreKit", path: "./Frameworks/SCSDKCoreKit.xcframework"),
        .binaryTarget(name: "SCSDKCreativeKit", path: "./Frameworks/SCSDKCreativeKit.xcframework"),
        .target(name: "MyLibrary", dependencies: ["SCSDKCameraKit", "SCSDKCoreKit", "SCSDKCreativeKit"], path: "./Sources")
    ]
)
