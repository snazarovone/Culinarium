//
//  CafeViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CafeViewModelType {
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> CafeCellViewModelType
    func getFilterListCafe() -> BehaviorRelay<CafeModel?>
    func didSelectCafe(indexPath: IndexPath) -> Cafe
    func getAuth() -> ErrorAuth?
}
