//
//  Socials.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum Socials: CaseIterable{
    case vk
    case fb
}

extension Socials{
    var tag: Int{
        switch self {
        case .vk:
            return 0
        case .fb:
            return 1
        }
    }
    
    var selectIcon: UIImage{
        switch self {
        case .vk:
            return #imageLiteral(resourceName: "vk_select")
        case .fb:
            return #imageLiteral(resourceName: "fb_select")
        }
    }
    
    var unseslect: UIImage{
          switch self {
          case .vk:
              return #imageLiteral(resourceName: "vk_unselect")
          case .fb:
              return #imageLiteral(resourceName: "fb_unselect")
          }
      }
    
    var title: String{
        switch self {
        case .vk:
            return "vk"
        case .fb:
            return "facebook"
        }
    }
}
