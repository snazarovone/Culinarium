//
//  ArrayDeepCopy.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

//Protocal that copyable class should conform
protocol Copying {
    init(original: Self)
}

//Concrete class extension
extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

//Array extension for elements conforms the Copying protocol
extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}
