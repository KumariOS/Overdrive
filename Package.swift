import PackageDescription

var package = Package(
    name: "Overdrive",
    targets: [
        Target(name: "Overdrive"),
        Target(name: "Extensions"),
        Target(name: "URLSession",
               dependencies: [
                .Target(name: "Overdrive")
            ])
    ],
    exclude: [
        "Sources/Support",
        "Tests/Support"
    ]
)
