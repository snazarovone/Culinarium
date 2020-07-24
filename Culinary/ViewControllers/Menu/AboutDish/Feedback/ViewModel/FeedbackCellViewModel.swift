//
//  FeedbackCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class FeedbackCellViewModel: FeedbackCellViewModelType{
    var imgUser: String?
    
    var titleFeed: String?
    
    var ratingCount: String?
    
    var nameUserAndDate: String?
    
    var textFeed: String?
    
    
    init(feedback: FeedUser){
        self.imgUser = feedback.user?.image
        self.titleFeed = feedback.caption
        self.ratingCount = "\(feedback.rating ?? 0)"
        self.nameUserAndDate = "\(feedback.user?.name ?? ""), \(feedback.created_at ?? "")"
        self.textFeed = feedback.text
    }
}
