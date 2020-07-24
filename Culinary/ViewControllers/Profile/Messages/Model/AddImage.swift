//
//  AddImage.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum AddImage {
    case img1
    case img2
    case img3
}

extension AddImage{
    var tag: Int{
        switch self {
        case .img1:
            return 0
        case .img2:
            return 1
        case .img3:
            return 2
        }
    }
}
