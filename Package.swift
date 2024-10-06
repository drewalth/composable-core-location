// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "composable-core-location",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
  ],
  products: [
    .library(
      name: "ComposableCoreLocation",
      targets: ["ComposableCoreLocation"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.15.0"),
  ],
  targets: [
    .target(
      name: "ComposableCoreLocation",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]),
    .testTarget(
      name: "ComposableCoreLocationTests",
      dependencies: ["ComposableCoreLocation"]),
  ])
