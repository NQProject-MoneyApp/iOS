//
//  UIImageVIew.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/09/2021.
//

import Foundation
import UIKit

extension UIImageView {
    
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UIImage {
    /// Given a required height, returns a (rasterised) copy
    /// of the image, aspect-fitted to that height.
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
