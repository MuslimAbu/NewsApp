//
//  Fonts.swift
//  NewsApp
//
//  Created by Муслим on 06.04.2024.
//

import UIKit

struct Fonts {
    
    static func chango(size: CGFloat) -> UIFont {
        UIFont(name: "Chango-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
