//
//  ArticleListNetworkService.swift
//  NewsApp
//
//  Created by Муслим on 07.04.2024.
//

import Foundation

final class ArticleListNetworkService {
    
    private var page = 1
    
    private var urlString: String {
        "https://newsapi.org/v2/everything?q=tesla&from=2024-03-09&sortBy=publishedAt&apiKey=2e482f6ca0464157b484417919eb343e&language=ru&page=\(page)"
    }
    
    func fetchData(page: Int, completion: @escaping ([Article]) -> Void) {
        self.page = page
        
        guard let url = URL(string: urlString) else {return}
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _ , error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            
            guard let result = try? JSONDecoder().decode(ArticlesResult.self, from: data) else {
                print("can not decode data")
                return
            }
            completion(result.articles)
        }.resume()
    }
}
