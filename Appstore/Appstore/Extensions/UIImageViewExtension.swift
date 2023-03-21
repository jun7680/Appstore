//
//  UIImageViewExtension.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/20.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        ImageCache.shared.requestImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
