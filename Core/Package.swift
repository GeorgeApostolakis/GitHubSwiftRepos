// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Core",
            targets: ["Core"]
        ),
        .library(
            name: "CoreTestSupport",
            targets: ["CoreTestSupport"]
        )
    ],
    dependencies: [
        .package(
          url: "https://github.com/pointfreeco/swift-snapshot-testing",
          exact: "1.17.7"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Core",
            path: "Core"
        ),
        .target(
            name: "CoreTestSupport",
            dependencies: [
                "Core",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            path: "CoreTestSupport"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        ),
    ]
)
