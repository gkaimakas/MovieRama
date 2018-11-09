//
//  TextTableViewCell.swift
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

public class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    public var configuration: Configuration? {
        didSet {
            guard let configuration = configuration else {
                contentLabel.text = nil
                return
            }
            
            contentLabel.reactive.attributedText <~ configuration
                .content
                .take(until: reactive.prepareForReuse)
                .observe(on: UIScheduler())
            
            contentLabel.reactive.textColor <~ configuration
                .contentType
                .take(until: reactive.prepareForReuse)
                .observe(on: UIScheduler())
                .map { $0.textColor }
            
            contentLabel.reactive.font <~ configuration
                .contentType
                .take(until: reactive.prepareForReuse)
                .observe(on: UIScheduler())
                .map { $0.font }
            
        }
    }
    
}

extension ContentTableViewCell {
    public enum ContentType {
        case title
        case label
        case content
        
        var textColor: UIColor {
            switch self {
            case .title:
                return MDCPalette.indigo.tint500
            case .label:
                return MDCPalette.indigo.tint400
            case .content:
                return UIColor.darkGray
            }
        }
        
        var font: UIFont {
            switch self {
            case .title:
                return UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
            case .label:
                return UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
            case .content:
                return UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            }
        }
    }
    
    public class Configuration {
        let contentType: SignalProducer<ContentType, NoError>
        let content: SignalProducer<NSAttributedString?, NoError>
        
        
        public init(contentType: SignalProducer<ContentType, NoError>,
                    content: SignalProducer<NSAttributedString?, NoError>) {
            
            self.contentType = contentType
            self.content = content
        }
        
        public convenience init(contentType: ContentType,
                                content: SignalProducer<NSAttributedString?, NoError>) {
            
            self.init(contentType: SignalProducer<ContentTableViewCell.ContentType, NoError>(value: contentType),
                      content: content)
        }
        
        public convenience init(contentType: ContentType,
                                content: SignalProducer<String?, NoError>) {
            
            self.init(contentType: SignalProducer(value: contentType),
                      content: content.map { $0 == nil ? nil : NSAttributedString(string: $0!) })
        }
        
        public convenience init(contentType: ContentType,
                                content: String?) {
            
            self.init(contentType: SignalProducer(value: contentType),
                      content: SignalProducer<NSAttributedString?, NoError>(value: content == nil ? nil : NSAttributedString(string: content!)))
        }
    }
}
