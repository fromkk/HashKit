// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "HashKit",
    products: [
        .library(name: "HashKit", targets: ["HashKit"])
    ],
    targets: [
        .target(
            name: "HashKit",
            path: "Sources",
            exclude: []
        )
    ]
)
