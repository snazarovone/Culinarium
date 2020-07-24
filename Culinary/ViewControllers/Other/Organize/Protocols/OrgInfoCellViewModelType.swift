//
//  OrgInfoCellViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol OrgInfoCellViewModelType: class{
    var img: UIImage? {get}
    var titleInfo: String? {get}
    var descriptionInfo: String? {get}
    var linkText: String? {get}
    var hideLinkBtn: Bool? {get}
    var hideDescriptionInfo: Bool? {get}
}
