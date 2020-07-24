//
//  BallsViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol BallsViewModelType{
    func numberOfRowsInSection (at section: Int) -> Int
    func cellForRowAt (at indexPath: IndexPath) -> BallsEarnModelType
}
