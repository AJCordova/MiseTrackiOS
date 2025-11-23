// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FirebaseServices",
    platforms: [
        .iOS("18.4")
      ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FirebaseServices",
            targets: ["FirebaseServices"]
        ),
    ],
    dependencies: [
        .package(path: "../../Base/Models"),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            from: "12.6.0"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FirebaseServices",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
            ]
        ),
        .testTarget(
            name: "FirebaseServicesTests",
            dependencies: ["FirebaseServices"]
        ),
    ]
)
