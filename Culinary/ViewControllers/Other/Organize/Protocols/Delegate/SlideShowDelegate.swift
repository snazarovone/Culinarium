//
//  SlideShowDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol SlideShowDelegate: OrganizeDelegate {
    func didChangePage(at page: Int)
}
