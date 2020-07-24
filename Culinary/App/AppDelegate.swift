//
//  AppDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import CoreData
import Moya
import RxSwift
import YandexMapKit
import VK_ios_sdk
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var authService: AuthService!
    
    private let MAPKIT_API_KEY = "3b4cf0bf-f82b-48ca-9768-a07f8c284e91"

    //если значение true не показываем алерт с информацие цен
    //до следующего перезапуска приложения
    var didShowCatMenu = false
    var didShowAlertFeedback = false
    
    //MARK:- Providers
    let providerAuthServerAPI = MoyaProvider<AuthServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                            plugins: [NetworkLoggerPlugin(verbose: false)])
    let providerMenuSectionsServerAPI = MoyaProvider<MenuServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                                    plugins: [NetworkLoggerPlugin(verbose: true)])
    
    let providerFeedbackServerAPI = MoyaProvider<FeedbackServerAPI>(manager: DownloadAlamofireManager.sharedManager,
                                                                    plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    
    let providerFiltersServerAPI = MoyaProvider<FiltersServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                                  plugins: [NetworkLoggerPlugin(verbose: false, cURL: false)])
    
    let providerWishlistServerAPI = MoyaProvider<WishlistServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                                    plugins: [NetworkLoggerPlugin(verbose: false)])
    
    let providerInfoUserServerAPI = MoyaProvider<InfoUserServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                                    plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    let providerCafeServerAPI = MoyaProvider<CageServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                            plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    
    let providerContactsServerAPI = MoyaProvider<ContactsServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                            plugins: [NetworkLoggerPlugin(verbose: true)])
    
    let providerBasketServerAPI = MoyaProvider<BasketServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                            plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    let providerHistoryServerAPI = MoyaProvider<HistoryServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                                  plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    let providerStocksServerAPI = MoyaProvider<StocksServerAPI>(manager: DefaultAlamofireManager.sharedManager,
                                                                 plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    
    
    let disposeBag = DisposeBag()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        YMKMapKit.setApiKey(MAPKIT_API_KEY)
      
        self.authService = AuthService()
        
        //MARK:- Facebook SignIn
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        let vk = VKSdk.processOpen(url, fromApplication:  UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
//        let fb = ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        return false
        
    }
    // MARK: UISceneSession Lifecycle

    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Culinary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
