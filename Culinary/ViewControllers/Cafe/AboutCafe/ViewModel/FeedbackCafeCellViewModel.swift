//
//  FeedbackCafeCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 25.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class FeedbackCafeCellViewModel: AboutCafeModels, FeedbackCellViewModelType {
    
    var typeCell: AboutCafeType{
        return .feedback
    }
   
    var imgUser: String?{
        return feed.user?.image
    }
    
    var titleFeed: String?{
        return feed.strengths
    }
    
    var ratingCount: String?{
        return "\(feed.rating ?? 5)"
    }
    
    var nameUserAndDate: String?{
        var name = feed.user?.name ?? ""
        if name != ""{
            name += " "
        }
        
        var surname = feed.user?.surname ?? ""
        if surname != ""{
            surname += " "
        }

        
        return "\(name)\(surname) \(feed.date ?? "")"
    }
    
    var textFeed: String?{
        return feed.text
    }
    
    private let feed: FeedbackCafe
    
    init(feed: FeedbackCafe){
        self.feed = feed
    }
}
