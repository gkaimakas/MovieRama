//
//  Date.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import ReactiveSwift
import Foundation

extension Date {
    public func string(format: String,
                       timezone: TimeZone = TimeZone.current) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
}

extension Signal where Value == Date {
    public func string(format: String, timezone: TimeZone = TimeZone.current) -> Signal<String, Error> {
        return map { $0.string(format: format, timezone: timezone) }
    }
}

extension Signal where Value == Date? {
    public func string(format: String, timezone: TimeZone = TimeZone.current) -> Signal<String?, Error> {
        return map { $0?.string(format: format, timezone: timezone) }
    }
}

extension SignalProducer where Value == Date {
    public func string(format: String, timezone: TimeZone = TimeZone.current) -> SignalProducer<String, Error> {
        return lift { $0.string(format: format, timezone: timezone) }
    }
}

extension SignalProducer where Value == Date? {
    public func string(format: String, timezone: TimeZone = TimeZone.current) -> SignalProducer<String?, Error> {
        return lift { $0.string(format: format, timezone: timezone) }
    }
}

extension Property where Value == Date {
    public func string(format: String, timezone: TimeZone = TimeZone.current) -> Property<String> {
        return map { $0.string(format: format, timezone: timezone) }
    }
}

extension Property where Value == Date? {
    public func string(format: String, timezone: TimeZone = TimeZone.current) -> Property<String?> {
        return map { $0?.string(format: format, timezone: timezone) }
    }
}
