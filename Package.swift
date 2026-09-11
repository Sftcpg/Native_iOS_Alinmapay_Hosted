// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "HostedIOSAlinmapay",

    platforms: [
        .iOS(.v12)
    ],

    products: [
        .library(
            name: "HostedIOSAlinmapay",
            targets: ["HostedIOSAlinmapay"]
        )
    ],

    targets: [
        .target(
            name: "HostedIOSAlinmapay",
            path: "hosted-ios-plugin/Sources",
            resources: [
                .process("PaymentController/StoryBoard")
            ],
            linkerSettings: [
                .linkedFramework("UIKit")
            ]
        )
    ]
)