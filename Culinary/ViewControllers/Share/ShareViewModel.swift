//
//  ShareViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class ShareViewModel: ShareViewModelType{
    var shareType: ShareType
    
    init(shareType: ShareType){
        self.shareType = shareType
    }
}
