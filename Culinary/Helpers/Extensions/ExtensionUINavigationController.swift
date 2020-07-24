//
//  ExtensionUINavigationController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
