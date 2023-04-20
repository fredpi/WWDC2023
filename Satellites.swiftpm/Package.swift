// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Satellites",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "Satellites",
            targets: ["AppModule"],
            bundleIdentifier: "de.fredpi.satellites",
            teamIdentifier: "7A8KUDWX52",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad
            ],
            supportedInterfaceOrientations: [
                .landscapeRight,
                .landscapeLeft
            ],
            capabilities: [
                .camera(purposeString: "To show the scene in AR, access to the camera is required.")
            ],
            appCategory: .education
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)