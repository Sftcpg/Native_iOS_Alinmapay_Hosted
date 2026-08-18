// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "hosted-ios-plugin",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "hosted-ios-plugin",
            targets: ["hosted-ios-plugin"]
        )
    ],
    targets: [
        .target(
            name: "hosted-ios-plugin",
            path: "hosted-ios-plugin/Sources/",
            resources: [
                .process("PaymentController/StoryBoard")
            ]
        )
    ]
)
