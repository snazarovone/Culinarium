//
//  TabBar.swift
//  Culinary
//
//  Created by Sergey Nazarov on 16.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
  override var traitCollection: UITraitCollection {
    guard UIDevice.current.userInterfaceIdiom == .pad else {
      return super.traitCollection
    }

    return UITraitCollection(horizontalSizeClass: .compact)
  }
}
