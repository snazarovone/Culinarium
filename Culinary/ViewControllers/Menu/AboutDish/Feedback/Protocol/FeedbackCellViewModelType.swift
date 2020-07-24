//
//  FeedbackCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol FeedbackCellViewModelType: class {
    var imgUser: String? {get}
    var titleFeed: String? {get}
    var ratingCount: String? {get}
    var nameUserAndDate: String? {get}
    var textFeed: String? {get}
}
