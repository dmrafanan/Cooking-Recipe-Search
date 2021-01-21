//
//  RecipeAPI.swift
//  p7
//
//  Created by Monica Ong on 2/20/18.
//  Copyright © 2018 CS 1998. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum SearchType {
    case ingredients
    case title
}

class NetworkManager {
    
    private static let recipePuppyURL = "http://www.recipepuppy.com/api"
    
    static func getRecipe(fromIngredients ingredients: [String], _ didGetRecipes: @escaping ([Recipe]) -> Void) {

        //        var recipePuppyURLTitle = recipePuppyURL + "/?i="
        var ingredientsArray:String = ""
        for i in ingredients.indices {
            ingredientsArray.append(ingredients[i])
            if i != ingredients.index(before: ingredients.endIndex){
                ingredientsArray.append(",")
            }
        }
        let parameter:[String:Any] = ["i":ingredientsArray]
        
                AF.request(recipePuppyURL, method: .get, parameters: parameter).validate().responseData{ response in
        
                    switch response.result{
                    case .success(let data):
                        let jsonData = JSON(data)
                        let jsonResults = jsonData["results"]
                        var recipes:[Recipe] = []
                        jsonResults.array?.forEach { (json) in
                            let recipe = Recipe(title: json["title"].stringValue, ingredients: json["ingredients"].stringValue, thumbnailURL: json["thumbnail"].stringValue,href: json["href"].stringValue)
                            recipes.append(recipe)
                        }
                        didGetRecipes(recipes)
        
                    case .failure(let _):
                        print("error3")
                    }
                }
    }
    
    static func getRecipe(fromTitle title: String, _ didGetRecipes: @escaping ([Recipe]) -> Void) {
        // TODO: Fill in this function. This function should make a network request
        // to the Recipe Puppy API given a title and then call the
        // didGetRecipes closure after you receive a response and decode it.
        let parameter:[String:Any] = ["q":title]
        AF.request(recipePuppyURL, method: .get,parameters: parameter).validate().responseData{ response in
            
            switch response.result{
                
            case .success(let data):
                let jsonData = JSON(data)
                let jsonResults = jsonData["results"]
                var recipes:[Recipe] = []
                jsonResults.array?.forEach { (json) in
                    let recipe = Recipe(title: json["title"].stringValue, ingredients: json["ingredients"].stringValue, thumbnailURL: json["thumbnail"].stringValue,href: json["href"].stringValue)
                    recipes.append(recipe)
                }
                didGetRecipes(recipes)
                
            case .failure(let error):
                print("error1")
            }
        }
    }
    static func fetchThumbnailImage(imageURL:String,completion: @escaping (UIImage) -> Void){
        AF.request(imageURL, method: .get).validate().responseData{ (response) in
            switch response.result{
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(image)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getImage(fromURL URL:String,completion: @escaping (UIImage?) -> Void){
        AF.request(URL).validate().response{ response in
            switch response.result{
            case .success(let data):
                if let data = data{
                    let imageData = UIImage(data: data)
                    completion(imageData)
                }
            case .failure:
                print("error2")
                completion(UIImage(named: "image"))
            }
        }
    }
}
