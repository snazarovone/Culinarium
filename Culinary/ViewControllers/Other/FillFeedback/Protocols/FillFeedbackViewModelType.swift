//
//  FillFeedbackViewModelType.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol FillFeedbackViewModelType{
    func numberOfRow(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> BMenuCollectionCellViewModelType
    func didSelect(at indexPath: IndexPath)
    func getAuth() -> ErrorAuth?
    
    func numberOfRowImages() -> Int
    func cellForRowImage(at indexPath: IndexPath) -> AddingImageVIewModelType
    func didSelectImage(at indexPath: IndexPath) -> ImagesPicker
    func updateGalery(image: UIImage?)
    func removeImage(at indexPath: IndexPath)
    func getImages() -> [Data]
    
    func getItemDataFeedback() -> FeedBackType
    func phoneUser() -> String?
    func nameUser() -> String?
    func sernameUser() -> String?
    func formattedNumber(number: String) -> String
    func nameSelectCafe() -> String?
    func nameSelectDish() -> String?
    func getListDish() -> BehaviorRelay<[DishMainInfo]>
    func getListCafe() -> BehaviorRelay<CafeModel?>
}
