//
//  Recipe.swift
//  p7
//
//  Created by Monica Ong on 2/20/18.
//  Copyright © 2018 CS 1998. All rights reserved.
//

import UIKit

struct Recipe:Codable {
    let title: String
    let ingredients: String
    let thumbnailURL:String
    let href:String
}

struct RecipeSearchResponse:Codable {
    var results: [Recipe]
}
