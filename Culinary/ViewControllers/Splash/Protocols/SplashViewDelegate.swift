//
//  SplashViewDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 19.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol SplashViewDelegate: class {
    func requestGetBasket()
    func requestMyAddresses()
    func requestUserInfo()
    func requestHistoryOrders()
}
