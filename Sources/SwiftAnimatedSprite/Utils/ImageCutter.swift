#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
public typealias PlatformImage = NSImage
#elseif canImport(UIKit)
import UIKit
public typealias PlatformImage = UIImage
#endif

import SwiftUI


enum ImageCutter {

    static func cut(imageName: String, rows: Int, columns: Int) -> [[Image]] {
        guard let originalImage = PlatformImage(named: imageName) else {
            return []
        }

        let originalSize = CGSize(width: originalImage.size.width, height: originalImage.size.height)
        let cutWidth = originalSize.width / CGFloat(columns)
        let cutHeight = originalSize.height / CGFloat(rows)

        var cutImages: [[Image]] = []

        for row in 0..<rows {
            var rowImages: [Image] = []

            for column in 0..<columns {
                let startX = CGFloat(column) * cutWidth
                let startY = CGFloat(row) * cutHeight

                let cropRect = CGRect(x: startX, y: startY, width: cutWidth, height: cutHeight)

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
                if let cgImage = originalImage.cgImage(forProposedRect: nil, context: nil, hints: nil)?.cropping(to: cropRect) {
                    let cutImage = Image(nsImage: PlatformImage(cgImage: cgImage, size: originalSize))
                    rowImages.append(cutImage)
                }
#elseif canImport(UIKit)
                if let cgImage = originalImage.cgImage?.cropping(to: cropRect) {
                    let cutImage = Image(uiImage: PlatformImage(cgImage: cgImage))
                    rowImages.append(cutImage)
                }
#endif

            }
            cutImages.append(rowImages)
        }
        return cutImages
    }
}
