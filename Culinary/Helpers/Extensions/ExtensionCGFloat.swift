//
//  ExtensionCGFloat.swift
//  Culinary
//
//  Created by Sergey Nazarov on 02.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
