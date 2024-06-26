//
//  ArticleListNetworkService.swift
//  NewsApp
//
//  Created by Муслим on 07.04.2024.
//

import Foundation

final class ArticleListNetworkService {
    
    func fetchData(
        q: String?,
        page: Int,
        completion: @escaping (ArticlesResult) -> Void
    ){
        let urlString = urlString(q: q, page: page)
        
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response , error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            
            guard let result = try? JSONDecoder().decode(ArticlesResult.self, from: data) else {
                print("Can not decode data")
                return
            }
            
            completion(result)
        }.resume()
    }
    
    private func urlString(q: String?, page: Int) -> String {
        
        var baseString = "https://newsapi.org/v2/everything?sortBy=publishedAt&apiKey=2e482f6ca0464157b484417919eb343e&language=ru"
        
        if let q = q {
            baseString += "&q=\(q)"
        }
        
        baseString += "&page=\(page)"
        
        return baseString
    }
    
    private func convert(from result: [ArticleResult]) -> [Article] {
        let articles: [Article] = result.compactMap { item in
            guard let title = item.title,
                  let description = item.description,
                  let author = item.author,
                  let urlToImage = item.urlToImage,
                  let url = item.url,
                  let publishedAt = publishedAt(for: item.publishedAt)
            else {
               return nil
            }
            return Article(
                title: title,
                description: description,
                author: author, 
                urlToImage: urlToImage,
                url: url,
                publishedAt: publishedAt
            )
        }
        return articles
    }
    
    private func publishedAt(for dateResult: String?) -> String? {
        guard let dateResult = dateResult,
              let date = ISO8601DateFormatter().date(from: dateResult)
        else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: date)
    }
}
