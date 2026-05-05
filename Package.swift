// swift-tools-version:5.9
import PackageDescription
import Foundation

let package = Package(
    name: "SwiftTasksVision",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SwiftTasksVision",
            targets: ["SwiftTasksVision"]
        ),
        .executable(
            name: "UpdatePackage",
            targets: ["UpdatePackage"]
        )
    ],
    targets: [
        // -ObjC linker flag intentionally OMITTED. The upstream package applies
        // it, which forces all Obj-C classes from the binary frameworks to also
        // be statically linked into the consuming app's main binary — but
        // because these are dynamic XCFrameworks that get embedded in the
        // app's Frameworks/ dir, the same classes end up in two places
        // ("Class X is implemented in both ..." runtime warnings). For dynamic
        // XCFramework binary targets the flag is unnecessary; categories
        // resolve through the dynamic load.
        .target(
            name: "SwiftTasksVision",
            dependencies: ["MediaPipeCommonGraphLibraries", "MediaPipeTasksVision", "MediaPipeTasksCommon"]
        ),
        .binaryTarget(
            name: "MediaPipeTasksVision",
            path: "Dependencies/MediaPipeTasksVision.xcframework"
        ),
        .binaryTarget(
            name: "MediaPipeCommonGraphLibraries",
            path: "Dependencies/MediaPipeCommonGraphLibraries.xcframework"
        ),
        .binaryTarget(
            name: "MediaPipeTasksCommon",
            path: "Dependencies/MediaPipeTasksCommon.xcframework"
        ),
        .executableTarget(
            name: "UpdatePackage",
            resources: [
                .process("Resources/MediaPipeVision.Info.plist")
            ]
        ),
    ]
)
