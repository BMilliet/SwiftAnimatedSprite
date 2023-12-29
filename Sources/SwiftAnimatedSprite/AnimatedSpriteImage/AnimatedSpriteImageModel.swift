import SwiftUI

final class AnimatedSpriteImageModel: ObservableObject {

    @Published var image: AnyView = AnyView(Rectangle())

    private var imageArray = [Image]()
    private var currentImageCount = 0
    private var frameRate: Float = 0.0
    private var imageWidth: CGFloat = 0
    private var imageHeight: CGFloat = 0
    private var loop: Bool = false
    private var animationPlaying = false
    private var timerCount = 0


    func setup(data: AnimatedSpriteImageData) {
        self.imageArray    = data.imageArray
        self.frameRate     = data.frameRate
        self.imageWidth    = data.imageWidth
        self.imageHeight   = data.imageHeight
        self.loop          = data.loop
        startTimer()
    }

    func stop() {
        animationPlaying = false
        timerCount -= 1
    }

    func play() {
        startTimer()
    }


    private func startTimer() {
        if timerCount > 0 { return }
        animationPlaying = true
        timerCount += 1
        _ = Timer.scheduledTimer(
            timeInterval: TimeInterval(frameRate),
            target: self,
            selector: #selector(update),
            userInfo: nil,
            repeats: true
        )
    }


    @objc private func update(timer: Timer) {
        if !animationPlaying || timerCount > 1 {
            timer.invalidate()
            return
        }

        image = AnyView(
            imageArray[currentImageCount]
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
                .aspectRatio(contentMode: .fit)
        )

        currentImageCount += 1

        if currentImageCount >= imageArray.count {
            currentImageCount = 0

            if !loop {
                stop()
            }
        }
    }
}
