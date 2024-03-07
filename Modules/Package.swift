// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Coordinators_Api",
            targets: ["Coordinators_Api"]),
        .library(
            name: "Coordinators_Impl",
            targets: ["Coordinators_Impl"]),
        .library(
            name: "DataStore_Api",
            targets: ["DataStore_Api"]),
        .library(
            name: "DataStore_Impl",
            targets: ["DataStore_Impl"]),
        .library(
            name: "Model",
            targets: ["Model"]),
        .library(
            name: "ViewModels_Api",
            targets: ["ViewModels_Api"]),
        .library(
            name: "ViewModels_Impl",
            targets: ["ViewModels_Impl"]),
        .library(
            name: "Services_Api",
            targets: ["Services_Api"]),
        .library(
            name: "Services_Impl",
            targets: ["Services_Impl"]),
        .library(
            name: "Views",
            targets: ["Views"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Coordinators_Api",
            dependencies: [
                "Model"
            ],
            path: "Modules/Coordinators/Sources/Api"
        ),
        .target(
            name: "Coordinators_Impl",
            dependencies: [
                "Coordinators_Api",
                "DataStore_Impl",
                "ViewModels_Impl",
                "Services_Impl",
                "Model",
                "Views"
            ],
            path: "Modules/Coordinators/Sources/Impl"
        ),
        .testTarget(
            name: "Coordinators_Impl_Test",
            dependencies: [
                "Coordinators_Impl"
            ],
            path: "Modules/Coordinators/Tests"
        ),
        .target(
            name: "DataStore_Api",
            dependencies: [
                "Model"
            ],
            path: "Modules/DataStore/Sources/Api"
        ),
        .target(
            name: "DataStore_Impl",
            dependencies: [
                "DataStore_Api",
                "Model"
            ],
            path: "Modules/DataStore/Sources/Impl"
        ),
        .testTarget(
            name: "DataStore_Impl_Test",
            dependencies: [
                "DataStore_Impl"
            ],
            path: "Modules/DataStore/Tests"
        ),
        .target(
            name: "Model",
            dependencies: [],
            path: "Modules/Model"
        ),
        .target(
            name: "Services_Api",
            dependencies: [
                "Model"
            ],
            path: "Modules/Services/Sources/Api"
        ),
        .target(
            name: "Services_Impl",
            dependencies: [
                "Model",
                "Services_Api"
            ],
            path: "Modules/Services/Sources/Impl"
        ),
        .testTarget(
            name: "Services_Impl_Test",
            dependencies: [
                "Services_Impl"
            ],
            path: "Modules/Services/Tests"
        ),
        .target(
            name: "ViewModels_Api",
            dependencies: [
                "Model"
            ],
            path: "Modules/ViewModels/Sources/Api"
        ),
        .target(
            name: "ViewModels_Impl",
            dependencies: [
                "DataStore_Api",
                "Model",
                "Services_Api",
                "ViewModels_Api"
            ],
            path: "Modules/ViewModels/Sources/Impl"
        ),
        .testTarget(
            name: "ViewModels_Impl_Test",
            dependencies: [
                "ViewModels_Impl"
            ],
            path: "Modules/ViewModels/Tests"
        ),
        .target(
            name: "Views",
            dependencies: [
                "Coordinators_Api",
                "ViewModels_Api"
            ],
            path: "Modules/Views"
        )
    ]
)
