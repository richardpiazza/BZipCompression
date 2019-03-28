// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BZipCompression",
    products: [
        .library(name: "BZipCompression", targets: ["BZipCompression"]),
    ],
    dependencies: [
        .package(url: "https://github.com/richardpiazza/Cbz2.git", from: "1.0.1"),
    ],
    targets: [
        .target(name: "BZipCompression", dependencies: []),
        .testTarget(name: "BZipCompressionTests", dependencies: ["BZipCompression"]),
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
