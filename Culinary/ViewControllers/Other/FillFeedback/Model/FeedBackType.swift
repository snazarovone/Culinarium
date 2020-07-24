//
//  FeedBackType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class FeedBackType{
    
    let name: String
    let titleName: String?
    let segueID: String?
    
    init(name: String, titleName: String?, segueID: String?){
        self.name = name
        self.titleName = titleName
        self.segueID = segueID
    }
}
