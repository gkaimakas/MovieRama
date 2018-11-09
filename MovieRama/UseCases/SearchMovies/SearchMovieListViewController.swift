//
//  SearchMovieListViewController.swift
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

class SearchMovieListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var parentViewController: UIViewController?
    
    var viewModel: SearchMovieListViewModel!
    var diffCalculator: CollectionViewDiffCalculator<String, Row>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UIApplication.inject(SearchMovieListViewModel.self)
        diffCalculator = CollectionViewDiffCalculator<String, Row>(collectionView: collectionView)
        
        collectionView.register(MovieOverviewCell.self)
        collectionView.register(LoadingCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel
            .movies
            .producer
            .map { list -> [Row] in
                return list.map { Row.movie($0) }
            }
            .observe(on: UIScheduler())
            .on(value: { [weak self] rows in
                self?.diffCalculator.sectionedValues = SectionedValues([("", rows)])
            })
            .start()
    }
}

extension SearchMovieListViewController: UICollectionViewDataSource {
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

extension SearchMovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.movies.value.count - 1
            && viewModel.fetchMovies.isEnabled.value == true {
            viewModel
                .fetchMovies
                .apply()
                .start()
        }
        
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .movie(let movie):
            if let cell = cell as? MovieOverviewCell {
                cell.viewModel = movie
            }
        case .isLoading:
            break
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
            print(type(of: parent))
            presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
        case .isLoading:
            break
        }
    }
}

extension SearchMovieListViewController: UICollectionViewDelegateFlowLayout {
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
