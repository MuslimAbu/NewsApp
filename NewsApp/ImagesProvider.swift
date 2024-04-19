//
//  ImagesProvider.swift
//  NewsApp
//
//  Created by Муслим on 13.04.2024.
//

import UIKit

final class ImagesProvider {
    
    private var images: [String:UIImage?] = [:]
    
    func image(for url: URL) -> UIImage? {
        images[url.absoluteString] ?? UIImage(named: "article")
    }
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = images[url.absoluteString] {
            completion(nil)
            return
        } else {
            fetchImage(url: url, completion: completion)
        }
    }
    
    private func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _ ,error in
            guard let data = data, error == nil else { return }
            
            let image = UIImage(data: data)
            
            self.images[url.absoluteString] = image
            
            completion(image)
        }.resume()
    }
}
