//
//  StoryboardsName.swift
//  Culinary
//
//  Created by Sergey Nazarov on 02.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

//Имя файлов всех сторибордов проекта

enum StoryboardsName{
    case main
    case loginApp
    case feedback
    case balls
    case coupons
    case favorites
    case stocks
    case seasonTickets
    case freez
    case profile
    
    //MARK:- Tabs
    case tabMain
    case menu
    
    
}

extension StoryboardsName{
    var name: String{
        switch self {
        case .main:
            return "Main"
        case .loginApp:
            return "LoginApp"
        case .tabMain:
            return "TabMain"
        case .feedback:
            return "Feedback"
        case .balls:
            return "Balls"
        case .coupons:
            return "Coupons"
        case .favorites:
            return "Favorites"
        case .stocks:
            return "Stocks"
        case .seasonTickets:
            return "SeasonTickets"
        case .freez:
            return "Freez"
        case .profile:
            return "Profile"
        case .menu:
            return "Menu"
        }
    }
}
