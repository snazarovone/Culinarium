//
//  StocksDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

protocol StocksDelegate: TabMainDelegate{
    func feedback()
    func myBalls()
    func allStocks()
    func profile()
}
