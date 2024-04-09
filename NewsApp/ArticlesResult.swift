//
//  AllArticleResult.swift
//  NewsApp
//
//  Created by Муслим on 07.04.2024.
//

import Foundation

struct ArticlesResult: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
