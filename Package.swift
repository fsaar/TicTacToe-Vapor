import PackageDescription
 
let package = Package(
    name: "tictactoe",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0, minor: 16)
    ]
)

