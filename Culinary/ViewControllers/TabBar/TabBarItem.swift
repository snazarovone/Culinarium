//
//  TabBarItem.swift
//  Culinary
//
//  Created by Sergey Nazarov on 02.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class TabBarItem: UITabBarItem {
    //choose normal and selected fonts here
    let normalTitleFont = UIFont(name: "Rubik-Medium", size: 11.0)!
    let selectedTitleFont = UIFont(name: "Rubik-Medium", size: 11.0)!
    
    //choose normal and selected colors here
    let normalTitleColor : UIColor = UIColor(named: "UITabBarUnselectTitle")!
    let selectedTitleColor : UIColor = UIColor(named: "UITabBarSelectTitle")!

    
    //assigns the proper initial state logic when each tab instantiates
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //this tag # should be your primary tab's Tag*
        if self.tag == 1 {
            self.setTitleTextAttributes([NSAttributedString.Key.font: selectedTitleFont, NSAttributedString.Key.foregroundColor: selectedTitleColor], for: UIControl.State.normal)
        } else {
            self.setTitleTextAttributes([NSAttributedString.Key.font: normalTitleFont, NSAttributedString.Key.foregroundColor: normalTitleColor], for: UIControl.State.normal)
        }
    }
}
