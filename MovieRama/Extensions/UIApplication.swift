//
//  UIApplication.swift
//  MovieRama
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import UIKit

extension UIApplication {
    static var appDelegate: AppDelegate {
        return shared.appDelegate
    }
    
    var appDelegate: AppDelegate {
        return self.delegate as! AppDelegate
    }
    
    static func inject<T>(_ type: T.Type) -> T {
        guard let object = appDelegate
            .container
            .resolve(type) else {
                fatalError("Could not inject \(T.self)")
        }
        
        return object
    }
}
