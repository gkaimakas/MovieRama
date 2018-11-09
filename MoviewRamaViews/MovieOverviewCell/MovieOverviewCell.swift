//
//  MovieOverviewCell.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MaterialComponents
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

public class MovieOverviewCell: MDCCardCollectionCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedAtLabel: UILabel!
    @IBOutlet weak var voteAverageLevel: UILabel!
    @IBOutlet weak var toggleFavoriteButton: UIButton!
    
    public weak var viewModel: MovieOverviewCellDriver? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            titleLabel.reactive.text <~ viewModel
                .title
                .producer
                .take(until: reactive.prepareForReuse)
            
            releasedAtLabel.reactive.text <~ viewModel
                .releasedAt
                .producer
                .take(until: reactive.prepareForReuse)
                .string(format: "d MMM YYYY")
            
            voteAverageLevel.reactive.text <~ viewModel
                .voteAverage
                .producer
                .take(until: reactive.prepareForReuse)
                .map { "\u{2605} \($0)" }
            
            toggleFavoriteButton.reactive.pressed = CocoaAction(viewModel.toggleFavorite)
            toggleFavoriteButton.reactive.title <~ viewModel
                .isFavorite
                .producer
                .take(until: reactive.prepareForReuse)
                .map { $0 ? "favorite" : "not" }
            
            
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
