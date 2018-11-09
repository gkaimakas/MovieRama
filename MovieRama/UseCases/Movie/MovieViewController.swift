//
//  MovieViewController.swift
//  MovieRama
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Dwifft
import MovieRamaCommon
import MovieRamaViewModels
import MoviewRamaViews
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var diffCalculator: TableViewDiffCalculator<String, Row>!
    weak var viewModel: MovieViewModel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        diffCalculator = TableViewDiffCalculator(tableView: tableView)
        tableView.register(ContentTableViewCell.self)
        tableView.register(FavoriteTableViewCell.self)
        tableView.register(SimilarMoviesTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 256))
        headerView.contentMode = .scaleAspectFill
        headerView.reactive.urlImage <~ viewModel
            .backdropURL
            .producer
            .observe(on: UIScheduler())
            .skipNil()
            .map { $0.backdrop(width: .w780) }
            .map { ($0, nil) }
        
        tableView.tableHeaderView = headerView
        
        viewModel
            .reviews
            .reviews
            .producer
            .combineLatest(with: viewModel.fetchInfo.isExecuting.producer)
            .map { list, _ -> [Row] in
                guard list.count > 0 else {
                    return []
                }

                return [
                    .label("Reviews"),
                    .padding(8)
                    ]
                    +  list.flatMap { review -> [Row] in
                    return [
                        .subLabel(review.author.value),
                        .padding(4),
                        .content(review.content),
                        .padding(8),
                    ]
                }
            }
            .combineLatest(with: viewModel.similarMovies.movies.producer)
            .on(value: { [weak self] reviewRows, similarMovieList in
                guard let self = self,
                    let viewModel = self.viewModel else {
                    return
                }
                
                let genres = viewModel
                    .genres
                    .value
                    .compactMap { $0.name.value }
                    .joined(separator: ", ")
                
                let castList = viewModel
                    .cast
                    .value
                    .compactMap { $0.name.value }
                    .joined(separator: ", ")
                
                let director = viewModel
                    .crew
                    .value
                    .first

                var persistentRows: [Row] = [
                    .padding(16),
                    .title(viewModel.title),
                    .padding(0),
                    .content(Property<String?>(value: genres)),
                    .padding(16),
                    .favorite,
                    .padding(16),
                    .label("Description"),
                    .padding(4),
                    .content(viewModel.overview),
                    .padding(16)
                ]
                
                if let director = director {
                    persistentRows.append(contentsOf: [
                        .label("Director"),
                        .padding(4),
                        .content(director.name),
                        .padding(16)
                        ])
                }
                
                if castList.isEmpty == false {
                    persistentRows.append(contentsOf: [
                        .label("Cast"),
                        .padding(4),
                        .content(Property<String?>(value: castList)),
                        .padding(8)
                        ])
                }
                
                if similarMovieList.count > 0 {
                    persistentRows.append(contentsOf: [
                        .padding(8),
                        .similarMovies,
                        .padding(8)
                        ])
                }

                self.diffCalculator.sectionedValues = SectionedValues([
                    ("", persistentRows + reviewRows)
                    ])
            })
            .start()
        
        viewModel
            .reviews
            .fetchReviews
            .apply()
            .start()
        
        viewModel
            .fetchInfo
            .apply()
            .start()
        
        viewModel
            .similarMovies
            .fetchSimilarMovies
            .apply()
            .start()
    }
    
}

extension MovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return diffCalculator.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diffCalculator.numberOfObjects(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .title(let property):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, indexPath: indexPath)
            cell.configuration = ContentTableViewCell.Configuration(contentType: .title,
                                                                    content: property.producer)
            return cell
            
        case .label(let property):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, indexPath: indexPath)
            cell.configuration = ContentTableViewCell.Configuration(contentType: .label,
                                                                    content: property)
            return cell
            
        case .subLabel(let property):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, indexPath: indexPath)
            cell.configuration = ContentTableViewCell.Configuration(contentType: .subLabel,
                                                                    content: property)
            return cell
            
        case .content(let property):
            let cell = tableView.dequeueReusableCell(ContentTableViewCell.self, indexPath: indexPath)
            cell.configuration = ContentTableViewCell.Configuration(contentType: .content,
                                                                    content: property.producer)
            return cell
            
        case .padding:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
            
        case .favorite:
            let cell = tableView.dequeueReusableCell(FavoriteTableViewCell.self, indexPath: indexPath)
            cell.viewModel = viewModel
            return cell
            
        case .similarMovies:
            let cell = tableView.dequeueReusableCell(SimilarMoviesTableViewCell.self, indexPath: indexPath)
            cell.viewModel = viewModel.similarMovies
            return cell
        }
    }
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .title:
            return UITableView.automaticDimension
            
        case .label:
            return UITableView.automaticDimension
            
        case .subLabel:
            return UITableView.automaticDimension
            
        case .content:
            return UITableView.automaticDimension
            
        case .favorite:
            return UITableView.automaticDimension
            
        case .similarMovies:
            return 200
            
        case .padding(let height):
            return height
        }
    }
}
