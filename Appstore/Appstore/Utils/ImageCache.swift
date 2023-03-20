//
//  ImageCache.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/20.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func requestImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let key = NSString(string: url.absoluteString)
        if let image = cache.object(forKey: key) {
            completion(image)
        }
        
        requestImage(url: url) { [weak self] data in
            guard let data = data else {
                completion(nil)
                return
            }

            if let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: key)
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    private func requestImage(url: URL, completion: @escaping (Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: url) {data, response, error in
                completion(data)
            }.resume()
        }
    }
}
