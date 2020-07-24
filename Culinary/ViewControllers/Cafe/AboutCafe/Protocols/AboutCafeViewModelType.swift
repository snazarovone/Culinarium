//
//  AboutCafeViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import MapKit

protocol AboutCafeViewModelType {
    func numberOfRow() -> Int
    func cellForRow(at indexPath: IndexPath) -> AboutCafeModels
    func getAuth() -> ErrorAuth?
    func isGetFeedback() -> Bool
    func getPhoneNumber() -> String?
    func getLocation() -> CLLocationCoordinate2D?
    func locationForYandexMap() -> (String, String)?
    func getNameCafe() -> String
    func getIdCafe() -> Int?
}
