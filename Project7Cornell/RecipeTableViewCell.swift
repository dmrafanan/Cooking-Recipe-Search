//
//  RecipeTableViewCell.swift
//  p7
//
//  Created by Monica Ong on 2/20/18.
//  Copyright © 2018 CS 1998. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let detailLabel = UILabel()
    var recipeImageView:UIImageView!
    var urlTextView: UITextView!
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide
        recipeImageView = UIImageView()
        contentView.addSubview(recipeImageView)

        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor,constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0 // make label multi-line
        titleLabel.adjustsFontSizeToFitWidth = true

        
        // Configure detailLabel

        
        urlTextView = UITextView()
        contentView.addSubview(urlTextView)
        urlTextView.translatesAutoresizingMaskIntoConstraints = false
        urlTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        urlTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        urlTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        urlTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor,constant: 8).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: urlTextView.topAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0 // make label multi-line
        detailLabel.adjustsFontSizeToFitWidth = true
        detailLabel.textColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
