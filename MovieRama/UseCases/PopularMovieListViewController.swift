//
//  ViewController.swift
//  MovieRama
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UIApplication.inject(PopularMovieListViewModel.self)
        
        collectionView.register(MovieOverviewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel
            .movies
            .producer
            .on(value: { [weak self] _ in
                self?.collectionView.reloadData()
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel
            .movies
            .value
            .count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MovieOverviewCell.self, indexPath: indexPath)
        cell.viewModel = viewModel
            .movies
            .value[indexPath.row]
        return cell
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
}

extension PopularMovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-32, height: 256)
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

