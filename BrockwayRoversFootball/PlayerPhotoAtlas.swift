import SwiftUI
import UIKit

enum PlayerPhotoAtlas {
    static let numbers: [Int] = [0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 15, 17, 30, 32, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 63, 66, 71, 77]
    private static let tile: CGFloat = 36
    private static let columns = 6

    private static let atlas: UIImage? = {
        let encoded = playerAtlasChunk0 + playerAtlasChunk1 + playerAtlasChunk2
        guard let data = Data(base64Encoded: encoded) else { return nil }
        return UIImage(data: data)
    }()

    static func image(for number: Int) -> UIImage? {
        guard let atlas,
              let index = numbers.firstIndex(of: number),
              let cg = atlas.cgImage else { return nil }
        let row = index / columns
        let column = index % columns
        let pixelTile = CGFloat(cg.width) / CGFloat(columns)
        let rect = CGRect(
            x: CGFloat(column) * pixelTile,
            y: CGFloat(row) * pixelTile,
            width: pixelTile,
            height: pixelTile
        ).integral
        guard let crop = cg.cropping(to: rect) else { return nil }
        return UIImage(cgImage: crop, scale: UIScreen.main.scale, orientation: .up)
    }
}
