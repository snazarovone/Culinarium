//
//  SplashViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import MapKit

class SplashViewController: UIViewController {
    
    //PRIVATE
    private let splashViewModel = SplashViewModel()
    private let locationManager = CLLocationManager()
    private var isRequestListCafe = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        checkLogin()
    }
    
    private func setupUserLocation(){
        // Ask for Authorisation from the User.
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        }else{
            print("Location services are not enabled")
        }
        
    }
    
    private func checkLogin(){
        if splashViewModel.checkLogin(){
            //переход на главный экран
            
            splashViewModel.requestListMeneSection { [weak self] (result) in
                switch result{
                case .complite:
                    
                    self?.setupUserLocation()
     
                    self?.splashViewModel.requestMyAddresses()
                    self?.splashViewModel.requestUserInfo()
                    self?.splashViewModel.requestNewsLetter()
                    self?.splashViewModel.requestAllDishes()
                    self?.splashViewModel.requestGetChats()
                    self?.splashViewModel.requestGetBasket()
                    self?.splashViewModel.requestListStocks()
                    
                    
                    //запрашиваем список избранных блюд
                    self?.splashViewModel.requestFavoriteDishes(callback: { [weak self] (result) in
                        switch result{
                        case .complite:
                            //переход на главный экран
                            self?.performSegue(withIdentifier: SegueID.tabBar.id, sender: nil)
                        case .error:
                            //открываем форму регистрации
                            if self?.splashViewModel.getAuth() != nil{
                                //открываем форму регистрации
                                self?.performSegue(withIdentifier: SegueID.loginApp.id, sender: nil)
                            }else{
                                //переход на главный экран
                                self?.performSegue(withIdentifier: SegueID.tabBar.id, sender: nil)
                            }
                        }
                    })
                case .error:
                    //открываем форму регистрации
                    self?.performSegue(withIdentifier: SegueID.loginApp.id, sender: nil)
                }
                
            }
        }else{
            //открываем форму регистрации
            performSegue(withIdentifier: SegueID.loginApp.id, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.loginApp.id{
            if let nav = segue.destination as? UINavigationController, let dvc = nav.topViewController as? LoginAppViewController{
                dvc.isComplite = {
                    [weak self] in
                    self?.checkLogin()
                }
            }
            return
        }
        
        if let identifier = segue.identifier, identifier == SegueID.tabBar.id{
            if let dvc = segue.destination as? TabBarViewController{
                dvc.menuSections = self.splashViewModel.getMenuSection()
                dvc.favoritesDish = self.splashViewModel.getFavoritesDish()
                dvc.myAddresses = self.splashViewModel.getMyAddresses()
                dvc.userInfo = self.splashViewModel.getUserInfo()
                dvc.newsLetter = self.splashViewModel.getNewsLetter()
                dvc.listCafe = self.splashViewModel.getListCafe()
                dvc.dishesMainInfo = self.splashViewModel.getDishesMainInfo()
                dvc.chatModel = self.splashViewModel.getChat()
                dvc.locationManager = self.locationManager
                dvc.basketModel = self.splashViewModel.getBasket()
                dvc.archivOrder = self.splashViewModel.getArchiveOrders()
                dvc.currentOrders = self.splashViewModel.getCurrentOrders()
                dvc.splashViewDelegate = self.splashViewModel
                dvc.stocks = self.splashViewModel.getStocks()
            }
            return
        }
    }
}

extension SplashViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        if isRequestListCafe == false{
            isRequestListCafe = true
            self.splashViewModel.requestListCafe(lat: "\(locValue.latitude)", lng: "\(locValue.longitude)")
        }else{
            //пересчитываем расстояние от меня до кафе
            self.splashViewModel.updateDistance(myLocation: manager.location!)
        }
    }
}
