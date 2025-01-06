// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "home-tools",
  platforms: [
    .macOS(.v14)
  ],
  dependencies: [
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
  ],
  targets: [
    .executableTarget(
      name: "HomeTools",
      dependencies: [
        .product(name: "Fluent", package: "fluent"),
        .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
        .product(name: "Leaf", package: "leaf"),
        .product(name: "Vapor", package: "vapor"),
      ]
    ),
    .testTarget(
      name: "HomeToolsTests",
      dependencies: [
        .target(name: "HomeTools"),
        .product(name: "XCTVapor", package: "vapor"),

        // Workaround for https://github.com/apple/swift-package-manager/issues/6940
        .product(name: "Vapor", package: "vapor"),
        .product(name: "Fluent", package: "Fluent"),
        .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
        .product(name: "Leaf", package: "leaf"),
      ]),
  ]
)
