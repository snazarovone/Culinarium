//
//  ContactDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
protocol ContactDelegate: class{
    func send(at mail: String)
    func call(at phone: String)
}
