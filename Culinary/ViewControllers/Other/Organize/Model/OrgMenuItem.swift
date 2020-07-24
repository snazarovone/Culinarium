//
//  OrgMenuItem.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

enum OrgMenuItem: CaseIterable{
    case banket
    case holidayInCafe
    case catering
}

extension OrgMenuItem{
    var title: String{
        switch self {
        case .banket:
            return "банкет"
        case .holidayInCafe:
            return "праздник в кафе"
        case .catering:
            return "кейтеринг"
        }
    }
    
    var infoModel: [OrgInfoModel]{
        switch self {
        case .banket:
            let info1 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_cost"), titleMain: "Стоимость", titleDescription: "от 500 ₽ на гостя", linkMap: nil)
            let info2 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_area"), titleMain: "Площадка", titleDescription: nil, linkMap: "Кафе на Автозаводской")
            let info3 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_guests"), titleMain: "Количество гостей", titleDescription: "до 200 человек", linkMap: nil)
            let info4 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_org_menu"), titleMain: "Меню", titleDescription: "300 блюд, под заказ", linkMap: nil)
            return [info1, info2, info3, info4]
        case .holidayInCafe:
            let info1 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_cost"), titleMain: "Стоимость", titleDescription: "от 500 ₽ на гостя", linkMap: nil)
            let info2 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_area"), titleMain: "Площадки", titleDescription: "3 кафе", linkMap: "Смотреть карту")
            let info3 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_org_menu"), titleMain: "Количество гостей", titleDescription: "300 блюд", linkMap: nil)
            return [info1, info2, info3]
        case .catering:
            let info1 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_cost"), titleMain: "Стоимость", titleDescription: "от 500 ₽ на гостя", linkMap: nil)
            let info2 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_area"), titleMain: "Площадка", titleDescription: nil, linkMap: "Кафе на Автозаводской")
            let info3 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_guests"), titleMain: "Количество гостей", titleDescription: "до 200 человек", linkMap: nil)
            let info4 = OrgInfoModel(img: #imageLiteral(resourceName: "ic_org_menu"), titleMain: "Меню", titleDescription: "300 блюд, под заказ", linkMap: nil)
            return [info1, info2, info3, info4]
        }
    }
    
    var infoDescription: String{
        switch self {
        default:
            return "Запланировали корпоративное мероприятие с размахом? Выберите одно из трех наших лучших заведений, определитесь с количеством гостей и забронируйте день мероприятия. Все остальное мы с удовольствием сделаем за вас! Звоните!"
        }
    }
}
