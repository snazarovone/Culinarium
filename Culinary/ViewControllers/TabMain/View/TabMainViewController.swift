//
//  TabMainViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class TabMainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //PRIVATE
    private var tabMainViewModel: TabMainViewModel!
    private weak var timer: Timer?
    
    //CellDelegates
    private weak var tabMainDelegate: TabMainDelegate?
    private weak var seasonTCollectionDelegate: SeasonTCollectionDelegate?
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabMainDelegate = self
        seasonTCollectionDelegate = self
        
        tabMainViewModel = TabMainViewModel(tabMainDelegate: tabMainDelegate, seasonTCollectionDelegate: seasonTCollectionDelegate, favoritesDish: getFavoritesDish(), stocks: getStocks())
        subscribes()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //MARK:- Permission
        switch(CLLocationManager.authorizationStatus()) {
        //check if services disallowed for this app particularly
        case .restricted, .denied:
            print("No access")
            DispatchQueue.main.async {
                self.openPermission()
            }
            
        //check if services are allowed for this app
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access! We're good to go!")
        //check if we need to ask for access
        case .notDetermined:
            print("asking for access...")
        @unknown default:
            print("authorizationStatus is unknown")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        super.viewWillAppear(animated)
        
        if let timer = timer, timer.isValid == false{
            startTimer()
        }else{
            if timer == nil{
                startTimer()
            }
        }
    }
    
    
    private func openPermission(){
        let alert = UIAlertController(title: "Предупреждение", message: "Для корректной работы приложения необходимо разрешить доступ к геопозиции, разрешить?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        
        let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Timer
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func endTimer() {
        if let timer = timer{
            timer.invalidate()
        }
    }
    
    
    //MARK:- Timer Update
    @objc private func updateTime() {
        let stocks = getStocks()
        var newActions = [StocksActions]()
        var removeActions = [StocksActions]()
        for st in stocks.value?.actions ?? []{
            if let dFormat = getEndTime(strData: st.date_end){
                if dFormat.timeIntervalSince1970 - Date().timeIntervalSince1970 > 0{
                    newActions.append(st)
                }else{
                    removeActions.append(st)
                }
            }else{
                removeActions.append(st)
            }
        }
        
        if removeActions.count > 0{
            stocks.value?.actions = newActions
            stocks.accept(stocks.value)
        }
    }
    
    private func getEndTime(strData: String?) -> Date?{
        if let dTime = strData{
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: dTime){
                return date
            }
        }
        return nil
    }
    
    //MARK:- Get Favorites Dish
    private func getFavoritesDish() -> BehaviorRelay<MenuSectionsModel?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.favoritesDish
        }else{
            let model: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    //MARK:- Get ListMyAddress
    private func getMyAddresses() -> BehaviorRelay<[AddressInfoUser]>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.myAddresses
        }else{
            return BehaviorRelay(value: [])
        }
    }
    
    //MARK:- Get ListStocks
    private func getStocks() -> BehaviorRelay<StocksModel?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.stocks
        }else{
            return BehaviorRelay(value: nil)
        }
    }
    
    //MARK:- Get UserInfo
    private func getUserInfo() -> BehaviorRelay<UserInfo?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.userInfo
        }else{
            return BehaviorRelay(value: UserInfo())
        }
    }
    
    //MARK:- Get NewsLetter info
    private func getNewsLetter() -> BehaviorRelay<NewsLetter>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.newsLetter
        }else{
            return BehaviorRelay(value: .notSubscribe)
        }
    }
    
    //MARK:- AllDishes
    private func getAllDish() -> BehaviorRelay<[DishMainInfo]>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.dishesMainInfo
        }else{
            let model: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
            return model
        }
    }
    
    //MARK:- Get List Cafe
    private func getListCafe() -> BehaviorRelay<CafeModel?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.listCafe
        }else{
            let model: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    //MARK:- Get Chat
    private func getChatUser() -> BehaviorRelay<[Chat]>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.chatModel
        }else{
            let model: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
            return model
        }
    }
    
    private func subscribes(){
        //MARK:- Subscribe Favorites
        getFavoritesDish().asObservable().subscribe(onNext: { [weak self] (value) in
            var count = 0
            if let value = value, let data = value.data{
                for d in data{
                    if let dishes = d.dishes{
                        count += dishes.count
                    }
                }
            }
            if count >= 0 && count <= 1{
                if let self = self{
                    self.tabMainViewModel = TabMainViewModel(tabMainDelegate: self.tabMainDelegate, seasonTCollectionDelegate: self.seasonTCollectionDelegate, favoritesDish: self.getFavoritesDish(), stocks: self.getStocks())
                    self.tableView.reloadData()
                }
            }
            
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        //MARK:- Subscribe Stocks
        getStocks().asObservable().subscribe(onNext: { [weak self] (value) in
            if let self = self{
                self.tabMainViewModel = TabMainViewModel(tabMainDelegate: self.tabMainDelegate, seasonTCollectionDelegate: self.seasonTCollectionDelegate, favoritesDish: self.getFavoritesDish(), stocks: self.getStocks())
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    
    //MARK:- About Tickets
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,  identifier == SegueID.aboutCoupon.id{
            if let dvc = segue.destination as? AboutCouponsViewController{
                dvc.typeAbout = .seasonTicket
            }
            return
        }
        
        //MARK:- Stocks
        if let identifier = segue.identifier,  identifier == SegueID.stocks.id{
            if let dvc = segue.destination as? StocksViewController, let senderVC = sender as? TabMainCellType{
                switch senderVC {
                case .tabMainCellStocks:
                    dvc.stocksViewModel = StocksViewModel(stocksAllType: .stocks, stocks: getStocks())
                default:
                    dvc.stocksViewModel = StocksViewModel(stocksAllType: .specialOffers)
                }
            }
            return
        }
        
        //MARK:- Profile
        if let identifier = segue.identifier,  identifier == SegueID.profile.id{
            if let dvc = segue.destination as? ProfileViewController{
                dvc.tabMainDelegate = self
                dvc.myAddresses = self.getMyAddresses()
                dvc.userInfo = self.getUserInfo()
                dvc.newsLetter = self.getNewsLetter()
                dvc.chatModel = self.getChatUser()
            }
        }
        
        //MARK:- Show About Dish
        if let identifier = segue.identifier, identifier == SegueID.aboutDishMain.id{
            if let dvc = segue.destination as? DishMainViewController{
                dvc.dish = sender as? DisheModel
                dvc.favoritesDish = getFavoritesDish()
                dvc.catMenuMainDelegate = self
            }
            return
        }
        
        //MARK:- FavoritesDish
        if let identifier = segue.identifier, identifier == SegueID.favorites.id{
            if let dvc = segue.destination as? FavoritesViewController{
                dvc.favoritesViewModel = FavoritesViewModel(favoritesDish: getFavoritesDish())
                dvc.catMenuMainDelegate = self
            }
            return
        }
        
        //MARK:- About Stock/Offer
        if let identifier = segue.identifier,  identifier == SegueID.aboutStock.id{
            if let dvc = segue.destination as? AboutStockViewController{
                dvc.stockCellViewModel = sender as? StockCellViewModel
            }
            return
        }
        
    }
    
    //MARK:- deinit
    deinit{
        print("TabMainViewController is deinit")
    }
}

//MARK:- TableView
extension TabMainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tabMainViewModel.numberOfRowsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tabMainViewModel.cellForRowAt(at: indexPath)
        
        switch dataCell.tabMainCellType{
        case .tabMainCellStocks:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainCellStocks.identifire) as! StocksTableViewCell
            cell.dataStock = dataCell as? StocksTableCellViewModelType
            cell.stocks = getStocks()
            cell.subscribe()
            return cell
        case .tabMainSeasonTickets:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainSeasonTickets.identifire) as! SeasonTicketsTableViewCell
            cell.dataSeasonTickets = dataCell as? SeasonTicketsTableViewCellType
            return cell
        case .tabMainCoupons:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainCoupons.identifire) as! CouponsTableViewCell
            cell.dataCoupons = dataCell as? CouponsTableCellViewModelType
            return cell
        case .tabMainBalls:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainBalls.identifire) as! BallsTableViewCell
            cell.dataBalls = dataCell as? BallsTableCellViewModelType
            return cell
        case .tabMainSpecialOffer:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainSpecialOffer.identifire) as! SpecialOfferTableViewCell
            cell.dataSpecialOffer = dataCell as? SpecialOfferTableCellViewModelType
            return cell
        case .tabMainFavorites:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainFavorites.identifire) as! FavoritesTableViewCell
            cell.favoritesDish = getFavoritesDish()
            cell.subscribes()
            cell.dataFovorites = dataCell as? FavoritesTableCellViewModelType
            return cell
        case .tabMainHit:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainHit.identifire) as! HitTableViewCell
            return cell
        case .tabMainJoinIn:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainJoinIn.identifire) as! JoinInTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataCell = tabMainViewModel.cellForRowAt(at: indexPath)
        return dataCell.heightCell
    }
}

//MARK:- Stocks Action
//обработка нажатий в ячейке Stocks
extension TabMainViewController: StocksDelegate{
    func profile() {
        performSegue(withIdentifier: SegueID.profile.id, sender: nil)
    }
    
    func feedback() {
        performSegue(withIdentifier: SegueID.feedback.id, sender: nil)
    }
    
    func myBalls() {
        performSegue(withIdentifier: SegueID.myBalls.id, sender: nil)
    }
    
    func allStocks() {
        performSegue(withIdentifier: SegueID.stocks.id, sender: TabMainCellType.tabMainCellStocks)
    }
}

//MARK:- Favorites Action
//обработка нажатий в ячейке Favorites
extension TabMainViewController: FavoritesDelegate{
    func showAboutFavoriteDish(dish: DisheModel) {
        performSegue(withIdentifier: SegueID.aboutDishMain.id, sender: dish)
    }
    
    func showAll() {
        performSegue(withIdentifier: SegueID.favorites.id, sender: nil)
    }
    
    
}

//MARK:- Balls Action
//обработка нажатий в ячейке таблицы Balls
extension TabMainViewController: BallsDelegate{
    func showEarnBalls() {
        performSegue(withIdentifier: SegueID.balls.id, sender: nil)
    }
}

//MARK:- Coupons
//обработка нажатий в ячейке таблицы Coupons
extension TabMainViewController: CouponsDelegate{
    func showCoupons() {
        performSegue(withIdentifier: SegueID.coupons.id, sender: nil)
    }
}

//обработка нажатий в ячейке коллекции Coupons
extension TabMainViewController: CouponsCollectionDelegate{
    func aboutAction() {
        performSegue(withIdentifier: SegueID.aboutCoupon.id, sender: nil)
    }
    
    func priceAction() {
        performSegue(withIdentifier: SegueID.aboutCoupon.id, sender: nil)
    }
}

extension TabMainViewController: StockCollectionDelegate{
    func aboutStock(stockCellViewModel: StockCellViewModel?) {
        performSegue(withIdentifier: SegueID.aboutStock.id, sender: stockCellViewModel)
    }
}

//MARK:- SeasonTickets
//обработка нажатий в ячейки таблицы SeasonTickets
extension TabMainViewController: SeasonTicketDelegate{
    func showAllSeasonTicket() {
        performSegue(withIdentifier: SegueID.seasonTickets.id, sender: nil)
    }
}

extension TabMainViewController: SeasontTicketTimeDelegate{
    func showSeasonTicketTime() {
        performSegue(withIdentifier: SegueID.aboutCoupon.id, sender: nil)
    }
}

extension TabMainViewController: SeasontTicketActivateDelegate{
    func showSeasontTicketActivate() {
        performSegue(withIdentifier: SegueID.aboutSeasonATicket.id, sender: nil)
    }
}


extension TabMainViewController: SpecialOfferDelegate{
    func allSpecialOffer() {
        performSegue(withIdentifier: SegueID.stocks.id, sender: TabMainCellType.tabMainSpecialOffer)
    }
    
}

extension TabMainViewController: TabMainDelegate{
    func logout() {
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            tabBarVC.removeDataAuth()
            tabBarVC.logout()
        }
    }
}

extension TabMainViewController: CatMenuMainDelegate{
    func showOverlay() {
    }
    
    func removeOverlay() {
    }
    
    func logOut() {
        logout()
    }
    
}



