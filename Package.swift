import PackageDescription

#if os(Linux)
let cocoa: [Target] = []
let linuxExcluded: [String] = ["Sources/Cocoa"]
#else
let cocoa: [Target] = [
    Target(name: "Cocoa",
           dependencies: [
            .Target(name: "Overdrive")
        ])
]
let linuxExcluded: [String] = []
#endif

var package = Package(
    name: "Overdrive",
    targets: [
        Target(
            name: "Overdrive"),
        Target(
            name: "TestSupport",
            dependencies: [
                .Target(name: "Overdrive")
            ]),
        Target(
            name: "OverdriveTests",
            dependencies: [
                .Target(name: "TestSupport")
            ]
        )
        ] + cocoa,
    exclude: [
        "Sources/Support",
        "Tests/Support"
        ] + linuxExcluded
)
