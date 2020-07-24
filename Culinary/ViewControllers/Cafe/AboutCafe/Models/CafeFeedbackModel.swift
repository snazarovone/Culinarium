//
//  CafeFeedbackModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class CafeFeedbackModel: AboutCafeModels {
    var typeCell: AboutCafeType{
        return .feedback
    }
    
    let feedbackCafe: FeedbackCafe
    
    init(feedbackCafe: FeedbackCafe){
        self.feedbackCafe = feedbackCafe
    }
}
