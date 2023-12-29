import SwiftUI

public struct AnimatedSpriteImage: View {

    @ObservedObject private var viewModel = AnimatedSpriteImageModel()

    init(imageName: String, columns: Int, frameRate: Float, loop: Bool, width: CGFloat, height: CGFloat) {
        // TODO: row is hard coded for now
        let imageArray = ImageCutter.cut(imageName: imageName, rows: 1, columns: columns)

        let imageData = AnimatedSpriteImageData(
            imageArray: imageArray.first!, // TODO: check
            frameRate: frameRate,
            imageWidth: width,
            imageHeight: height,
            loop: loop
        )

        viewModel.setup(data: imageData)
        viewModel.play()
    }


    public var body: some View {
        viewModel.image
    }

    func stop() {
        viewModel.stop()
    }

    func play() {
        viewModel.play()
    }
}
