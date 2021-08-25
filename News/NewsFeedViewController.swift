//
//  NewsFeedViewController.swift
//  News
//
//  Created by Nicholas Angelo Petelo on 8/22/21.
//

import UIKit

class NewsFeedViewController: UIViewController {

    var newsFeedService: NewsFeedService!
    var articles = [Article]()
    var offset = 0
    var moreToLoad = true
    var isFetching = false
    
    let newsLabelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News"
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 50.0)
        label.backgroundColor = .white
        return label
    }()
    
    let newsFeedTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(newsFeedService: NewsFeedService) {
        super.init(nibName: nil, bundle: nil)
        self.newsFeedService = newsFeedService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureTableView()
        addSubviews()
        addConstraints()
        fetchNewsFeed()
    }
    
    private func configureTableView() {
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
        newsFeedTableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: NewsFeedTableViewCell.identifier)
    }
    
    private func addSubviews() {
        view.addSubview(newsLabelView)
        view.addSubview(newsFeedTableView)
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // newsLabel
        constraints.append(newsLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(newsLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15))
        constraints.append(newsLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(newsLabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50))
        // tableView
        constraints.append(newsFeedTableView.topAnchor.constraint(equalTo: newsLabelView.bottomAnchor))
        constraints.append(newsFeedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(newsFeedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(newsFeedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        view.addConstraints(constraints)
    }
    
    private func fetchNewsFeed() {
        newsFeedService.getNewsFeed(offset: offset
        ) { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.articles.append(contentsOf: response.data.results)
                    self.offset += 10
                    self.moreToLoad = response.data.results.count < 10 ? false : true
                    self.newsFeedTableView.reloadData()
                }
            case .failure(let error):
                guard let self = self else { return }
                print(self.offset)
                print(error)
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsFeedTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.identifier) as! NewsFeedTableViewCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.authorLabel.text = articles[indexPath.row].author != "" ? "by " + articles[indexPath.row].author : ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ArticleViewController(article: articles[indexPath.row], imageService: ImageService()), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 1 && moreToLoad && !isFetching {
            fetchNewsFeed()
        }
    }

}


