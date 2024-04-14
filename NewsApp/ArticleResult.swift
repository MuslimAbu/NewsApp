//
//  Article.swift
//  NewsApp
//
//  Created by Муслим on 29.03.2024.
//

import UIKit

struct ArticleResult: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let content: String?
    let urlToImage: URL?
    let url: URL?
    let publishedAt: String
}
