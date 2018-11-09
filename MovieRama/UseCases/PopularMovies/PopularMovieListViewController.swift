//
//  ViewController.swift
//  MovieRama
//
//  Created by George Kaimakas on 08/11/2018.
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

class PopularMovieListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: PopularMovieListViewModel!
    var searchViewModel: SearchMovieListViewModel!
    var diffCalculator: CollectionViewDiffCalculator<String, Row>!
    let refreshControl = UIRefreshControl()
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UIApplication.inject(PopularMovieListViewModel.self)
        searchViewModel = UIApplication.inject(SearchMovieListViewModel.self)
        searchController = UISearchController(searchResultsController: StoryboardScene
            .Main
            .searchMovieListViewController
            .instantiate()
        )
        
        searchViewModel.query <~ searchController
            .searchBar
            .reactive
            .continuousTextValues
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationController?.definesPresentationContext = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        diffCalculator = CollectionViewDiffCalculator<String, Row>(collectionView: collectionView)
        
        collectionView.register(MovieOverviewCell.self)
        collectionView.register(LoadingCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.addSubview(refreshControl)
        
        refreshControl.reactive.refresh = CocoaAction(viewModel.forceFetchMovies)
        
        viewModel
            .movies
            .producer
            .map { list -> [Row] in
                return list.map { Row.movie($0) }
            }
            .combineLatest(with: viewModel
                .fetchMovies
                .isExecuting
                .producer
                .map { isLoading -> [Row] in
                    return isLoading == true ? [.isLoading] : []
                }
            )
            .observe(on: UIScheduler())
            .map {
                [
                    ("", $0.0),
                    ("", $0.1)
                ]
            }
            .on(value: { [weak self] rows in
                self?.diffCalculator.sectionedValues = SectionedValues(rows)
            })
            .start()
        
        
        
        viewModel
            .fetchMovies
            .apply()
            .start()
    }
}

extension PopularMovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return diffCalculator.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diffCalculator.numberOfObjects(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .movie(let movie):
            let cell = collectionView.dequeueReusableCell(MovieOverviewCell.self, indexPath: indexPath)
            cell.viewModel = movie
            return cell
        case .isLoading:
            let cell = collectionView.dequeueReusableCell(LoadingCollectionCell.self, indexPath: indexPath)
            return cell
        }
    }
}

extension PopularMovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == viewModel.movies.value.count - 1 {
            viewModel
                .fetchMovies
                .apply()
                .start()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch  diffCalculator.value(atIndexPath: indexPath) {
        case .movie(let movie):
            let viewController = StoryboardScene
                .Main
                .movieViewController
                .instantiate()
            
            viewController.viewModel = movie
            navigationController?.pushViewController(viewController, animated: true)
        case .isLoading:
            break
        }
    }
}

extension PopularMovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .movie:
            return CGSize(width: collectionView.frame.width-32, height: 256)
        case .isLoading:
            return CGSize(width: collectionView.frame.width-32, height: 48)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

