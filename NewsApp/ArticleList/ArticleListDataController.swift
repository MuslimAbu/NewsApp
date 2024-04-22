//
//  ArticleListDataController.swift
//  NewsApp
//
//  Created by Муслим on 20.04.2024.
//

import Foundation

final class ArticleListDataController {
    
    private var networkService = ArticleListNetworkService()
    
    func fetchData(
        q: String?,
        page: Int,
        completion: @escaping ([Article]) -> Void
    ) {
        networkService.fetchData(q: q, page: page) {[weak self] result in
            guard let self = self else { return }
            
            let articles = self.convert(from: result.articles)
            
            completion(articles)
        }
    }
    
    private func convert(from result: [ArticleResult]) -> [Article]{
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
