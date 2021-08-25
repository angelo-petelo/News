//
//  NewsFeedTableViewCell.swift
//  News
//
//  Created by Nicholas Angelo Petelo on 8/23/21.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    static let identifier = "NewsFeedTableViewCellIdentifier"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(authorLabel)
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // titleLabel
        constraints.append(titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15))
        constraints.append(titleLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor))
        // authorLabel
        constraints.append(authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15))
        constraints.append(authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15))
        constraints.append(authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15))
        constraints.append(authorLabel.heightAnchor.constraint(equalTo: authorLabel.heightAnchor))
        addConstraints(constraints)
    }
    
}
