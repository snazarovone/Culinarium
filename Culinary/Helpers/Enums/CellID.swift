//
//  CellID.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

enum CellID{
    //MARK:- TabMainCell
    case tabMainCellStocks
    case tabMainSeasonTickets
    case tabMainCoupons
    case tabMainBalls
    case tabMainSpecialOffer
    case tabMainFavorites
    case tabMainHit
    case tabMainJoinIn
    
    //MARK:- FavoritecCell
    case favoriteFilterAll
    case favoriteFilterOther
    case favoriteEat
    
    //MARK:- Balls
    case ballsMy
    case ballsHistory
    case ballAction
    case ballEarnFeedback
    case ballEarnShare
    case ballEarnBuyer
    case ballEarnProfile
    
    //MARK:- Coupons
    case couponsPrice
    case couponsAbout
    
    //MARK:- Stocks
    case stock
    case aboutStock
    
    //MARK:- SeasonTickets
    case seasonTTime
    case seasonTActivate
    
    //MARL:- Freez
    case day
    
    //MARK:- Profile
    case dialogs
    case message
    case address
    
    //MARK:- CatMenu
    case catMenu
    case menuLeftContaint
    case menuRightContaint
    case searchCell
    case galleryDish
    case feedBack
    case dishDescription
    case dishConsist
    case wightEatID
    case sectionQuickFilter
    
    //MAKR:- Basket
    case basketMenuItem
    case basketMenuItemCollection
    case basketGift
    case basketCountDish
    case basketDish
    case basketAdditionally
    case basketNotForget
    case bNotForgetDishCollectionView
    case basketPromotionalTableViewCell
    case basketTotal
    case saveAddress
    
    //MARK:- Other
    case otherRed
    case otherInfo
    case feedbackType
    case addImages
    case dishFeed
    case cafePlaces
    case contacts
    case pair
    
    //MARK:- Organization
    case orgMenu
    case orgSlideShowTableCell
    case orgSlideCollection
    case orgInfo
    case orgDescription
    
    //MARK:- Filter
    case filter
    
    //MARK:- DeliveryInfo
    case deliveryInfo2Line
    case deliveryInfo1Line
    case deliveryInfo2Line2Col
    
    //MARK:- Cafe
    case listCafe
    case cafeCollection
    case addressCafe
    case infoCafe
    case titleFeedback
    
    //MARK:- MyOrder
    case currentOrderInfo
    case currentOrderOnMap
    case histOrder
    case aboutOrderInfo
    case aboutOrderDish
}

extension CellID{
    var identifire: String{
        switch self {
        case .tabMainCellStocks:
            return "tabMainCellStocks"
        case .tabMainSeasonTickets:
            return "tabMainSeasonTickets"
        case .tabMainCoupons:
            return "tabMainCoupons"
        case .tabMainBalls:
            return "tabMainBalls"
        case .tabMainSpecialOffer:
            return "tabMainSpecialOffer"
        case .tabMainFavorites:
            return "tabMainFavorites"
        case .tabMainHit:
            return "tabMainHit"
        case .tabMainJoinIn:
            return "tabMainJoinIn"
        case .favoriteEat:
            return "favoriteEat"
        case .favoriteFilterAll:
            return "favoriteFilterAll"
        case .favoriteFilterOther:
            return "favoriteFilterOther"
        case .ballsMy:
            return "ballsMy"
        case .ballAction:
            return "ballAction"
        case .ballsHistory:
            return "ballsHistory"
        case .ballEarnFeedback:
            return "ballEarnFeedback"
        case .ballEarnShare:
            return "ballEarnShare"
        case .ballEarnBuyer:
            return "ballEarnBuyer"
        case .ballEarnProfile:
            return "ballEarnProfile"
        case .couponsPrice:
            return "couponsPrice"
        case .couponsAbout:
            return "couponsAbout"
        case .aboutStock:
            return "AboutStock"
        case .stock:
            return "StockCellID"
        case .seasonTTime:
            return "seasonTTime"
        case .seasonTActivate:
            return "seasonTActivate"
        case .day:
            return "day"
        case .dialogs:
            return "DialogTableViewCellID"
        case .message:
            return "MessageTableViewCellID"
        case .address:
            return "AddressTableViewCellID"
        case .catMenu:
            return "catMenu"
        case .menuLeftContaint:
            return "MenuLeftContaint"
        case .menuRightContaint:
            return "MenuRightContaint"
        case .searchCell:
            return "SearchTableViewCell"
        case .galleryDish:
            return "galleryDish"
        case .feedBack:
            return "FeedBackCellID"
        case .dishDescription:
            return "DishDescriptionCellID"
        case .wightEatID:
            return "WightEatID"
        case .dishConsist:
            return "dishConsistID"
        case .basketMenuItem:
            return "BasketMenuItem"
        case .basketMenuItemCollection:
            return "basketMenuItemCollection"
        case .basketGift:
            return "GiftCellID"
        case .basketCountDish:
            return "CountDishCellID"
        case .basketDish:
            return "BasketDishTableViewCell"
        case .basketAdditionally:
            return "AdditionallyCellID"
        case .basketNotForget:
            return "NotForgetCellID"
        case .bNotForgetDishCollectionView:
            return "BNotForgetDishCollectionViewCell"
        case .basketPromotionalTableViewCell:
            return "BasketPromotionalTableViewCell"
        case .basketTotal:
            return "BasketTotalTableViewCell"
        case .otherRed:
            return "OtherRedTableViewCellID"
        case .otherInfo:
            return "OtherInfoTableViewCellID"
        case .feedbackType:
            return "FeedbackTypeCellID"
        case .addImages:
            return "AddImageCollectionViewCell"
        case .dishFeed:
            return "DishFeedTableViewCellID"
        case .cafePlaces:
            return "CafePlaceTableViewCellID"
        case .orgMenu:
            return "OrgMenuTableViewCellD"
        case .orgSlideShowTableCell:
            return "OrgSlideShowTableCellID"
        case .orgSlideCollection:
            return "OrgSlideCollectionViewCellID"
        case .orgInfo:
            return "OrgInfoTableViewCellID"
        case .orgDescription:
            return "OrgDescriptionTableViewCellID"
        case .filter:
            return "FilterTableViewCellID"
        case .deliveryInfo2Line2Col:
            return "DeliveryInfo2Line2ColCellID"
        case .deliveryInfo1Line:
            return "DeliveryInfo1LineCellID"
        case .deliveryInfo2Line:
            return "DeliveryInfo2LineCellID"
        case .contacts:
            return "ContactTableViewCellID"
        case .listCafe:
            return "ListCafeTableViewCell"
        case .cafeCollection:
            return "CafeCollectionViewCellID"
        case .addressCafe:
            return "AddressCafeTableViewCellID"
        case .infoCafe:
            return "InfoCafeTableViewCellID"
        case .titleFeedback:
            return "TitleFeedback"
        case .pair:
            return "PairCellID"
        case .currentOrderInfo:
            return "CurrentOrderInfoTableViewCellID"
        case .currentOrderOnMap:
            return "CurrentOrderOnMapTableViewCellID"
        case .histOrder:
            return "HistOrderTableViewCellID"
        case .aboutOrderInfo:
            return "AboutOrderInfoTableViewCellID"
        case .aboutOrderDish:
            return "AboutOrderDishTableViewCellID"
        case .sectionQuickFilter:
            return "SectionQuickFilterCollectionViewCell"
        case .saveAddress:
            return "SaveAddressTableViewCellID"
        }
    }
}

