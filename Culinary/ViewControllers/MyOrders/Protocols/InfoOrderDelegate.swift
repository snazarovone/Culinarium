//
//  InfoOrderDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol InfoOrderDelegate: class {
    func aboutOrder(at id: Int?)
    func cancelOrder()
}
