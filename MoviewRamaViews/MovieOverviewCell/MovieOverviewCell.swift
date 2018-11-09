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
    @IBOutlet weak var wrapperView: UIView!
    
    public weak var viewModel: MovieOverviewCellDriver? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            imageView.reactive.urlImage <~ viewModel
                .backdropURL
                .producer
                .take(until: reactive.prepareForReuse)
                .observe(on: UIScheduler())
                .skipNil()
                .map { $0.backdrop(width: .w780) }
                .map { ($0, nil) }
                
            
            titleLabel.reactive.text <~ viewModel
                .title
                .producer
                .observe(on: UIScheduler())
                .take(until: reactive.prepareForReuse)
            
            releasedAtLabel.reactive.text <~ viewModel
                .releasedAt
                .producer
                .observe(on: UIScheduler())
                .take(until: reactive.prepareForReuse)
                .string(format: "d MMM YYYY")
            
            voteAverageLevel.reactive.attributedText <~ viewModel
                .voteAverage
                .producer
                .observe(on: UIScheduler())
                .take(until: reactive.prepareForReuse)
                .map { value -> NSAttributedString in
                    let intValue = Int(value/2)
                    let fullStars = Array<String>(repeating: "\u{2605}", count: intValue)
                    let emptyStars =  Array<String>(repeating: "\u{2605}", count: 5-intValue)
                    let stars = fullStars + emptyStars
                    let rating = stars.joined(separator: "")
                    
                    let result = NSMutableAttributedString(string: rating)
                    let range = (rating as NSString).range(of: fullStars.joined(separator: ""))
                    result.addAttributes([
                        NSAttributedString.Key.foregroundColor: MDCPalette.indigo.tint500
                        ], range: range)
                    
                    return result
                }
            
            toggleFavoriteButton.reactive.pressed = CocoaAction(viewModel.toggleFavorite)
            
            toggleFavoriteButton.reactive.image <~ viewModel
                .isFavorite
                .producer
                .observe(on: UIScheduler())
                .take(until: reactive.prepareForReuse)
                .map { $0 ? ViewAssets.favoriteBlack36pt.image : ViewAssets.favoriteBorderBlack36pt.image }
            
            
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        toggleFavoriteButton.tintColor = MDCPalette.red.tint500
        shadowElevation(for: MDCCardCellState.highlighted)
        imageView.layer.cornerRadius = cornerRadius
        wrapperView.round(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)
        
        titleLabel.textColor = MDCPalette.indigo.tint500
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
