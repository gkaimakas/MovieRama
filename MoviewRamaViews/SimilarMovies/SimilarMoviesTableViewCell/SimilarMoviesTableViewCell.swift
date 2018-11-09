//
//  SimilarMoviesTableViewCell.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 10/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Dwifft
import MaterialComponents
import MovieRamaCommon
import MovieRamaViewModels
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

public class SimilarMoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var diffCalculator: CollectionViewDiffCalculator<String, Row>!
    
    public var viewModel: SimilarMovieListViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
        
            viewModel
                .movies
                .producer
                .map { list -> [Row] in
                    return list.map { Row.movie($0) }
                }
                .combineLatest(with: viewModel
                    .fetchSimilarMovies
                    .isExecuting
                    .producer
                    .map { isLoading -> [Row] in
                        return isLoading == true ? [.isLoading] : []
                    }
                )
                .take(until: reactive.prepareForReuse)
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
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        diffCalculator = CollectionViewDiffCalculator<String, Row>(collectionView: collectionView)
        
        collectionView.register(SimilarMovieCell.self)
        collectionView.register(LoadingCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension SimilarMoviesTableViewCell: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return diffCalculator.numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diffCalculator.numberOfObjects(inSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .movie(let movie):
            let cell = collectionView.dequeueReusableCell(SimilarMovieCell.self, indexPath: indexPath)
            cell.viewModel = movie
            return cell
        case .isLoading:
            let cell = collectionView.dequeueReusableCell(LoadingCollectionCell.self, indexPath: indexPath)
            return cell
        }
    }
}

extension SimilarMoviesTableViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        
        if indexPath.item == viewModel.movies.value.count - 1
            && viewModel.fetchSimilarMovies.isEnabled.value == true {
            viewModel
                .fetchSimilarMovies
                .apply()
                .start()
        }
        
        switch diffCalculator.value(atIndexPath: indexPath) {
        case .movie:
            break
        case .isLoading:
            break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension SimilarMoviesTableViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height-16)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
