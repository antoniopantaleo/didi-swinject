// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "DidiSwinject",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DidiSwinject",
            targets: ["DidiSwinject"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/antoniopantaleo/didi.git",
            from: "2.0.0"
        ),
        .package(
            url: "https://github.com/Swinject/Swinject.git",
            from: "2.0.0"
        )
    ],
    targets: [
        .target(
            name: "DidiSwinject",
            dependencies: [
                .product(name: "Didi", package: "didi"),
                .product(name: "Swinject", package: "Swinject")
            ],
            swiftSettings: .approachableConcurrency
        ),
        .testTarget(
            name: "DidiSwinjectTests",
            dependencies: [
                .product(name: "Didi", package: "didi"),
                "DidiSwinject",
            ],
            swiftSettings: .approachableConcurrency
        )
    ]
)

fileprivate extension [SwiftSetting] {
    static var approachableConcurrency: [SwiftSetting] {
        [
            .defaultIsolation(MainActor.self),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances")
        ]
    }
}
