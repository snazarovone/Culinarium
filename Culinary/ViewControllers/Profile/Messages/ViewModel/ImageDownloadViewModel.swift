//
//  ImageDownloadViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class ImageDownloadViewModel: ImageDownloadViewModelType{
   
    var name: String?{
        return String(chatImage?.title?.prefix(14) ?? "")
    }
    
    var img: String?{
        return chatImage?.path
    }
    
    var titleSize: String?{
        return chatImage?.size
    }
    
    private let chatImage: ChatImage?
    
    init(chatImage: ChatImage?){
        self.chatImage = chatImage
    }
}
