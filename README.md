# SwiftAnimatedSprite

Use sprite sheets as animations in SwiftUI


## Import using SPM

```swift
import PackageDescription

let package = Package(
    name: "YourProject",
    products: [
        .library(
            name: "YourProject",
            targets: ["YourProject"]),
    ],
    dependencies: [
        .package(url: "https://github.com/BMilliet/SwiftAnimatedSprite", branch: "v1.0.0"),
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["Swift2D"]
        ),
        .testTarget(
            name: "YourProjectTests",
            dependencies: ["YourProject"]),
    ]
)
```


## Example

```swift
import SwiftUI
import SwiftAnimatedSprite

struct ContentView: View {

    @ObservedObject private var animatedSprite = AnimatedSprite(width: 200, height: 200)

    init() {
        animatedSprite.add(imageName: "walking_side", columns: 8, frameRate: 0.2)
        animatedSprite.add(imageName: "walking_up", columns: 4, frameRate: 0.2)
        animatedSprite.add(imageName: "walking_down", columns: 8, frameRate: 0.2)
        animatedSprite.add(imageName: "idle", columns: 8, frameRate: 0.4)
    }

    var body: some View {
        VStack {
            animatedSprite.animation

            HStack {
                Button {
                    animatedSprite.play("walking_side")
                } label: {
                    Text("side")
                }

                Button {
                    animatedSprite.play("walking_up")
                } label: {
                    Text("up")
                }

                Button {
                    animatedSprite.play("walking_down")
                } label: {
                    Text("down")
                }

                Button {
                    animatedSprite.play("idle")
                } label: {
                    Text("idle")
                }
            }
        }
        .padding()
    }
}
```