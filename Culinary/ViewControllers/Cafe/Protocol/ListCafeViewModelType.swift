//
//  ListCafeViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ListCafeViewModelType {
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> ListCafeCellViewModelType
    func getFilterListCafe() -> BehaviorRelay<CafeModel?>
    func didSelectCafe(at indexPath: IndexPath) -> Cafe
}
