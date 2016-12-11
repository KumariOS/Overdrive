import PackageDescription

var package = Package(
    name: "Overdrive",
    targets: [
        Target(name: "Overdrive"),
        Target(name: "Extensions"),
        Target(name: "URLSession", dependencies: ["Overdrive"]),
        Target(name: "TestSupport", dependencies: ["Overdrive"]),
        Target(name: "OverdriveTests", dependencies: ["TestSupport"]),
        Target(name: "URLSessionTests", dependencies: ["Overdrive", "URLSession", "TestSupport"])
    ],
    exclude: [
        "Sources/Support",
        "Tests/Support"
    ]
)
