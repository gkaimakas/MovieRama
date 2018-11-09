//
//  SimilarMovieCell.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 10/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//
import MaterialComponents
import MovieRamaCommon
import MovieRamaViewModels
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

public class SimilarMovieCell: MDCCardCollectionCell {
    @IBOutlet weak var imageView: UIImageView!
    
    weak var viewModel: SimilarMovieCellDriver? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            imageView.reactive.urlImage <~ viewModel
                .posterURL
                .producer
                .take(until: reactive.prepareForReuse)
                .observe(on: UIScheduler())
                .skipNil()
                .map { $0.poster(width: .w185) }
                .map { ($0, nil) }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = cornerRadius
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
