// swift-tools-version:5.2
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
        .package(url: "https://github.com/vapor/sqlite-nio.git", from: "1.0.0"),
        .package(url: "https://github.com/rnantes/sql-kit.git", .branch("all-encoding-strategies")),
        .package(url: "https://github.com/vapor/async-kit.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "SQLiteKit", dependencies: [
            .product(name: "AsyncKit", package: "async-kit"),
            .product(name: "SQLiteNIO", package: "sqlite-nio"),
            .product(name: "SQLKit", package: "sql-kit"),
        ]),
        .testTarget(name: "SQLiteKitTests", dependencies: [
            .product(name: "SQLKitBenchmark", package: "sql-kit"),
            .target(name: "SQLiteKit"),
        ]),
    ]
)
