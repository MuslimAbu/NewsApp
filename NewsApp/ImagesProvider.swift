//
//  ImagesProvider.swift
//  NewsApp
//
//  Created by Муслим on 13.04.2024.
//

import UIKit

final class ImagesProvider {
    
    private var images: [String:UIImage] = [:]
    
    func prefetchImages(urls: [URL]) {
        guard urls.count > 15 else {return}
        
        for url in urls {
            fetchImage(url: url)
        }
    }
    
    func image(for url: URL) -> UIImage {
        images[url.absoluteString] ?? UIImage()
    }
    
    private func fetchImage(url: URL) {
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) {data,_,error in
            guard let data = data, error == nil else {return}
            
            let image = UIImage(data: data)
            
            self.images[url.absoluteString] = image ?? UIImage()
            
            print(1)
        }.resume()
    }
}
