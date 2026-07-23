// swift-tools-version:5.9
//
// BluefinDecryptx SDK - SwiftPM manifest. Zero runtime dependencies (Foundation +
// the vendored Voxgig Struct port under Sources/ProjectNameSDK/Struct).
import PackageDescription

let package = Package(
    name: "BluefinDecryptxSdk",
    products: [
        .library(name: "BluefinDecryptxSdk", targets: ["BluefinDecryptxSdk"]),
    ],
    targets: [
        .target(
            name: "BluefinDecryptxSdk",
            path: "Sources/ProjectNameSDK"),
        .testTarget(
            name: "BluefinDecryptxSdkTests",
            dependencies: ["BluefinDecryptxSdk"],
            path: "Tests/ProjectNameSDKTests"),
    ]
)
