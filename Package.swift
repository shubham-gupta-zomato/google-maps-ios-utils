// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "google-maps-ios-utils",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "google-maps-ios-utils",
            targets: ["google-maps-ios-utils"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/googlemaps/ios-maps-sdk", .upToNextMajor(from: "8.3.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GoogleMapsUtilsObjC",
            dependencies: [
                .product(name: "GoogleMaps", package: "ios-maps-sdk"),
                .product(name: "GoogleMapsBase", package: "ios-maps-sdk"),
                .product(name: "GoogleMapsCore", package: "ios-maps-sdk")
            ],
            path: "Sources/ObjC/headers",
            publicHeadersPath: "."
        ),
        .target(
            name: "GoogleMapsUtilsSwift",
            dependencies: ["GoogleMapsUtilsObjC"],
            path: "Sources/Swift"
        ),
        .target(
            name: "GoogleMapsUtils",
            dependencies: ["GoogleMapsUtilsSwift"],
            path: "Sources/ObjC",
            exclude: ["headers"],
            cSettings: [
                .define("NS_BLOCK_ASSERTIONS", to: "1", .when(configuration: .release))
            ]
        )
    ]
)
