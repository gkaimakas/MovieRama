//
//  FavoriteTableViewCell.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 10/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MaterialComponents
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

public class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var toggleFavoriteButton: UIButton!
    @IBOutlet weak var releasedAtLabel: UILabel!
    @IBOutlet weak var voteAverateLabel: UILabel!
    
    public weak var viewModel: FavoriteTableViewCellDriver? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            releasedAtLabel.reactive.text <~ viewModel
                .releasedAt
                .producer
                .observe(on: UIScheduler())
                .take(until: reactive.prepareForReuse)
                .string(format: "d MMM YYYY")
            
            voteAverateLabel.reactive.attributedText <~ viewModel
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
    }
}
