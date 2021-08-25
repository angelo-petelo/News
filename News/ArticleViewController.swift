//
//  ArticleViewController.swift
//  News
//
//  Created by Nicholas Angelo Petelo on 8/23/21.
//

import UIKit

class ArticleViewController: UIViewController {

    var article: Article!
    var imageService: ImageService!
    
    let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let noImageFoundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Image Found"
        label.isHidden = true
        label.textColor = .darkGray
        return label
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    let articleImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"HelveticaNeue", size: 20.0)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue", size: 20.0)
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont(name:"HelveticaNeue", size: 20.0)

        return textView
    }()
    
    init(article: Article, imageService: ImageService) {
        super.init(nibName: nil, bundle: nil)
        self.article = article
        self.imageService = imageService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
        configureText()
        fetchImage()
        
    }
    
    private func addSubviews() {
        view.addSubview(imageContainerView)
        imageContainerView.addSubview(articleImageView)
        imageContainerView.addSubview(noImageFoundLabel)
        imageContainerView.addSubview(activityIndicatorView)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionTextView)
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // imageContainerView
        constraints.append(imageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(imageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(imageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(imageContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3))
        // noImageFoundLabel
        constraints.append(noImageFoundLabel.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor))
        constraints.append(noImageFoundLabel.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor))
        constraints.append(noImageFoundLabel.heightAnchor.constraint(equalTo: noImageFoundLabel.heightAnchor))
        constraints.append(noImageFoundLabel.widthAnchor.constraint(equalTo: noImageFoundLabel.widthAnchor))
        // activityIndicatorView
        constraints.append(activityIndicatorView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor))
        constraints.append(activityIndicatorView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor))
        constraints.append(activityIndicatorView.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(activityIndicatorView.widthAnchor.constraint(equalToConstant: 50))
        // articleImageView
        constraints.append(articleImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor))
        constraints.append(articleImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor))
        constraints.append(articleImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor))
        constraints.append(articleImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor))
        // titleLabel
        constraints.append(titleLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 15))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15))
        constraints.append(titleLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor))
        // authorLabel
        constraints.append(authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15))
        constraints.append(authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15))
        constraints.append(authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15))
        constraints.append(authorLabel.heightAnchor.constraint(equalTo: authorLabel.heightAnchor))
        // dateLabel
        constraints.append(dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 15))
        constraints.append(dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15))
        constraints.append(dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15))
        constraints.append(dateLabel.heightAnchor.constraint(equalTo: dateLabel.heightAnchor))
        // descriptionTextView
        constraints.append(descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15))
        constraints.append(descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11))
        constraints.append(descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11))
        constraints.append(descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        view.addConstraints(constraints)
    }
    
    private func configureText() {
        titleLabel.text = article.title
        authorLabel.text = article.author != "" ? "by " + article.author : ""
        dateLabel.text = article.date
        descriptionTextView.text = article.description
    }
    
    private func fetchImage() {
        guard let imageUrlString = article.image else {
            noImageFoundLabel.isHidden = false
            activityIndicatorView.stopAnimating()
            return }
        imageService.getImage(urlString: imageUrlString) { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.articleImageView.image = image
                    self.activityIndicatorView.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.noImageFoundLabel.isHidden = false
                    self.activityIndicatorView.stopAnimating()
                }
            }
             
        }
    }

}
