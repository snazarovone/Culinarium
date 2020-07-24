//
//  SegueID.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

//id всех переходов

enum SegueID {
    //MARK:- Splash
    case tabBar
    case loginApp
    
    //MARK:- Регистрация/Вход
    case restorePassword
    
    //MARK:- Feedback
    case feedback
    
    //MARK:- Favorites
    case favorites
    
    //MARK:- Balls
    case balls
    case myBalls
    
    //MARK:- Coupons
    case coupons
    case aboutCoupon
    case howGetBalls
    case howSpendBalls
    
    //MARK:- Stocks
    case stocks
    case aboutStock
    
    //MARK:- Share
    case share
    
    //MARK:- SeasonTickets
    case seasonTickets
    case aboutSeasonATicket
    
    //MARK:- Freez
    case listDays
    case freez
    
    //MARK:- Profile
    case profile
    case dialogs
    case messages
    case personalInformation
    case changePassword
    case mailing
    case addresses
    case addAddress
    case removeAddress
    case social
    
    //MARK:- menu
    case catMenu
    case searchMenu
    case galleryDish
    case aboutDishContainer
    case aboutDishMain
    case alertPriceDelivery
    case checkout
    case totalCheckout
    
    //MARK:- Others
    case orderAccepted
    case fillFeedback
    case dishFeed
    case alertFeed
    case cafePlaces
    case organize
    case deliveryInfo
    case settings
    case contacts
    case backCall
    case aboutCompany
    case informationProgramm
    
    //MARK:- Filters
    case filter
    
    //MARK:- Cafe
    case listCafe
    case aboutCafe
    
    //MARK:- MyOrder
    case myOrder
    case aboutOrder
    
}

extension SegueID{
    var id: String{
        switch self {
        case .tabBar:
            return "segueTabBarViewController"
        case .restorePassword:
            return "segueRestorePassword"
        case .loginApp:
            return "segueLoginApp"
        case .feedback:
            return "segueFeedbackViewController"
        case .favorites:
            return "segueFavoritesViewController"
        case .balls:
            return "segueBallsViewController"
        case .myBalls:
            return "segueMyBallsViewController"
        case .coupons:
            return "segueCouponsViewController"
        case .aboutCoupon:
            return "segueAboutCouponsViewController"
        case .howGetBalls:
            return "segueHowGetBallsViewController"
        case .howSpendBalls:
            return "segueHowSpendBallsViewController"
        case .stocks:
            return "segueStocksViewController"
        case .aboutStock:
            return "segueAboutStockViewController"
        case .share:
            return "segueShareViewController"
        case .seasonTickets:
            return "segueSeasonTicketsViewController"
        case .aboutSeasonATicket:
            return "segueAboutSeasonATicketViewController"
        case .listDays:
            return "segueListDaysViewController"
        case .freez:
            return "segueFreezViewController"
        case .profile:
            return "segueProfileViewController"
        case .dialogs:
            return "segueDialogsViewController"
        case .messages:
            return "segueMessagesViewController"
        case .personalInformation:
            return "seguePersonalInformationViewController"
        case .changePassword:
            return "segueChangePasswordViewController"
        case .mailing:
            return "segueMailingViewController"
        case .addresses:
            return "segueAddressesViewController"
        case .addAddress:
            return "segueAddAddressViewController"
        case .removeAddress:
            return "segueRemoveAddressViewController"
        case .social:
            return "segueSocialViewController"
        case .catMenu:
            return "segueCatMenuMainViewController"
        case .searchMenu:
            return "segueSearchMenuViewController"
        case .galleryDish:
            return "segueGalleryDishViewController"
        case .aboutDishContainer:
            return "segueAboutDishViewController"
        case .aboutDishMain:
            return "segueAboutDishMainViewController"
        case .alertPriceDelivery:
            return "segueAlertPriceDeliveryViewController"
        case .checkout:
            return "segueCheckoutViewController"
        case .totalCheckout:
            return "segueTotalCheckoutViewController"
        case .orderAccepted:
            return "segueOrderAcceptedViewController"
        case .fillFeedback:
            return "segueFillFeedbackViewController"
        case .dishFeed:
            return "segueDishFeedViewController"
        case .alertFeed:
            return "segueQAlertFeedbackViewController"
        case .cafePlaces:
            return "segueCafePlaceTableViewCell"
        case .organize:
            return "segueOrganizeViewController"
        case .filter:
            return "segueFilterID"
        case .deliveryInfo:
            return "segueDeliveryInfoViewController"
        case .settings:
            return "segueSettingsViewController"
        case .contacts:
            return "segueContactsViewController"
        case .backCall:
            return "segueBackCallViewController"
        case .listCafe:
            return "segueListCafe"
        case .aboutCafe:
            return "segueAboutCafeViewController"
        case .aboutCompany:
            return "AboutCompanyTableViewController"
        case .myOrder:
            return "segueMyOrdersViewController"
        case .aboutOrder:
            return "segueAboutOrderViewController"
        case .informationProgramm:
            return "segueProgrammLoyaltyViewController"
        }
    }
}
