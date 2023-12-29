import SwiftUI

public final class AnimatedSprite: ObservableObject {

    @Published public var animation: AnimatedSpriteImage?

    private let imageWidth: CGFloat
    private let imageHeight: CGFloat
    private var animatedScenes = [String: AnimatedSpriteImage]()


    public init(width: CGFloat, height: CGFloat) {
        self.imageWidth = width
        self.imageHeight = height
    }


    public func add(imageName: String, columns: Int, frameRate: Float, repeate: Bool) {

        let image = AnimatedSpriteImage(
            imageName: imageName,
            columns:   columns,
            frameRate: frameRate,
            repeate:   repeate,
            width:     self.imageWidth,
            height:    self.imageHeight
        )

        animatedScenes[imageName] = image
    }


    public func play(_ name: String) {
        guard let image = animatedScenes[name] else { return }
        stop()
        image.play()
        animation = image
    }


    public func stop() {
        animation?.stop()
    }
}
