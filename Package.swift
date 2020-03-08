// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "sqlite-kit",
    platforms: [
       .macOS(.v10_15),
       .iOS(.v11)
    ],
    products: [
        .library(name: "SQLiteKit", targets: ["SQLiteKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/sqlite-nio.git", from: "1.0.0-beta.2"),
        .package(url: "https://github.com/rnantes/sql-kit.git", .branch("all-encoding-strategies")),
        .package(url: "https://github.com/vapor/async-kit.git", from: "1.0.0-rc.1"),
    ],
    targets: [
        .target(name: "SQLiteKit", dependencies: [
            "AsyncKit",
            "SQLiteNIO",
            "SQLKit"
        ]),
        .testTarget(name: "SQLiteKitTests", dependencies: ["SQLKitBenchmark", "SQLiteKit", "SQLKit"]),
    ]
)
