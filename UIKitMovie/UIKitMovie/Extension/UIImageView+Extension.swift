// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Private Constants

private enum Constants {
    static let imageStartName = "https://image.tmdb.org/t/p/w500"
}

// MARK: - Расширение для UIImageView

extension UIImageView {
    func updateImageName(URLAddres: String) {
        let fullUrlImage = "\(Constants.imageStartName)\(URLAddres)"
        guard let url = URL(string: fullUrlImage) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let imageData = data {
                    if let loadedImage = UIImage(data: imageData) {
                        self.image = loadedImage
                    }
                }
            }
        }.resume()
    }
}
