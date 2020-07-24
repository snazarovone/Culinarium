//
//  MyBallsViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol MyBallsViewModelType{
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> MyBallsType
}
