import SwiftUI

final class AnimatedSpriteImageModel: ObservableObject {

    @Published var image: AnyView = AnyView(Rectangle())

    private var timer: Timer?
    private var imageArray = [Image]()
    private var currentImageCount = 0
    private var frameRate: Float = 0.0
    private var imageWidth: CGFloat = 0
    private var imageHeight: CGFloat = 0
    private var loop: Bool = false


    func setup(data: AnimatedSpriteImageData) {
        self.imageArray    = data.imageArray
        self.frameRate     = data.frameRate
        self.imageWidth    = data.imageWidth
        self.imageHeight   = data.imageHeight
        self.loop          = data.loop
        startTimer()
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func play() {
        guard let _ = timer else { return }
        startTimer()
    }


    private func startTimer() {
        self.timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(frameRate),
            target: self,
            selector: #selector(update),
            userInfo: nil,
            repeats: true
        )

        guard let _timer = timer else { return }
        RunLoop.main.add(_timer, forMode: .common)
    }


    @objc private func update() {
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
