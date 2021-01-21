//
//  SearchViewController.swift
//  p7
//
//  Created by Monica Ong on 2/20/18.
//  Copyright © 2018 CS 1998. All rights reserved.
//

import UIKit

class IngredientsSearchVC: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchResultsUpdating {
    
    // MARK: View vars
    
    var tableView = UITableView()
    let receipCellIdentifier = "RecipeCell"
    var searchController: UISearchController!
    
    var recipes: [Recipe] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true

        title = "Recipes"
        view.addSubview(tableView)
        
        // Pin the tableview’s anchors to its superview
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.delegate = self
        //hello
        // Set up tableview logic
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: receipCellIdentifier)
        
        // Make tableview cells' height dynamically resize
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        // Set up search controller logic
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search by ingredients (deliminate \", \")"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
    }
    
    // MARK: UITableView Data Source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: receipCellIdentifier, for: indexPath) as! RecipeTableViewCell
        
        cell.titleLabel.text = recipes[indexPath.row].title
        
        cell.detailLabel.text = "Ingredients: \(recipes[indexPath.row].ingredients)"
        
        NetworkManager.getImage(fromURL: recipes[indexPath.row].thumbnailURL){
            cell.recipeImageView.image = $0
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: recipes[indexPath.row].href){
            UIApplication.shared.open(url)
            print("hello")
        }
    }
    
    
    // MARK: UISearchResultsUpdating Protocol
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if !searchText.isEmpty {
                    print("search by ingredients")
                    var ingredients = [String]()
                    var temp = String()
                    
                    for i in searchText.indices {
                        if searchText[i] == ","||i == searchText.index(before: searchText.endIndex){
                            if i == searchText.index(before: searchText.endIndex){
                                temp.append(searchText[i])
                            }
                            ingredients.append(temp)
                            temp.removeAll()
                        }else{
                            temp.append(searchText[i])
                        }
                    }
                    for i in ingredients.indices{
                        ingredients[i] = ingredients[i].replacingOccurrences(of: " ", with: ",")
                    }
                    NetworkManager.getRecipe(fromIngredients: ingredients) {
                        self.recipes = $0
                        print("succ1")
                        self.tableView.reloadData()
                    }
                }
            }
            else {
                self.recipes = []
                self.tableView.reloadData()
            }
        }
    }

