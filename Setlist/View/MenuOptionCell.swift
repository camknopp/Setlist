//
//  MenuOptionCell.swift
//  Setlists
//
//  Created by Cory Knopp on 4/5/20.
//  Copyright © 2020 Cory Knopp. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    let descriptionLabel: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.font = UIFont.systemFont(ofSize: 16)
       label.text = "Sample Text"
       return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .darkGray
        
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
    }
    
    // This is some weird method we need to implement in order to override init, just ignore it
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
