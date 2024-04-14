//
//  AllArticleResult.swift
//  NewsApp
//
//  Created by Муслим on 07.04.2024.
//

struct ArticlesResult: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleResult]
}
