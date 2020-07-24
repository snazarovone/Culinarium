//
//  DishMainViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DishMainViewController: UIViewController {
    
    @IBOutlet weak var favoriteBtn: UIButtonDesignable!
    @IBOutlet weak var shareBtn: UIButtonDesignable!
    @IBOutlet weak var basketBtn: UIButtonDesignable! //isHide if >= 1 product
    @IBOutlet weak var minusBtn: UIButtonDesignable!
    @IBOutlet weak var plusBtn: UIButtonDesignable!
    @IBOutlet weak var countProtuct: UITextFieldDesignable!
    @IBOutlet weak var viewCounInBasket: UIStackView!
    
    //PRIVATE
    private var countProductInBasket = 0
    private weak var aboutDishBasketDelegate: AboutDishBasketDelegate?
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    private weak var tabBarVC: TabBarViewController!
    private var selectPortion: BehaviorRelay<PortionsDish?> = BehaviorRelay(value: nil)
    private var idDishInBasket: Int?
    
    //PUBLIC
    public var dish: DisheModel!
    public weak var catMenuMainDelegate: CatMenuMainDelegate?
    public var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTabBarVC()
        subscribes()
        
    }
    
    private func getTabBarVC(){
        guard let splashVC = UIApplication.shared.windows.first?.rootViewController as? SplashViewController else {return}
        
        for chieldVC in splashVC.children{
            if let tabBarVC = chieldVC as? TabBarViewController{
                self.tabBarVC = tabBarVC
                return
            }
        }
        if let tabBarVC = splashVC.presentedViewController as? TabBarViewController{
            self.tabBarVC = tabBarVC
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.aboutDishContainer.id{
            if let dvc = segue.destination as? AboutDishViewController{
                self.aboutDishBasketDelegate = dvc
                dvc.dish = self.dish
                dvc.dishMainDelegate = self
                dvc.selectPortion = self.selectPortion
            }
            return
        }
    }
    
    private func subscribes(){
        //MARK:- Favorites Dish
        
        favoritesDish.asObservable().subscribe(onNext: { [weak self] (value) in
            if let value = value, let data = value.data{
                for d in data{
                    for dish in d.dishes ?? []{
                        if let id = dish.id, id == self?.dish.id{
                            self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_red"), for: .normal)
                            return()
                        }
                    }
                }
            }
            self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_unselect"), for: .normal)
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        //MARK:- Basket
        tabBarVC.basketModel.asObservable().subscribe(onNext: { [weak self] (value) in
            if let self = self, let idDish = self.dish.id, let items = value?.items{
                for item in items{
                    if let idDishBasket = item.dish?.id, idDish == idDishBasket, let quantity = item.quantity{
                        self.idDishInBasket = item.id
                        self.countProductInBasket = quantity
                        self.aboutDishBasketDelegate?.inBasket(count: self.countProductInBasket)
                        self.countProtuct.text = "\(self.countProductInBasket)"
                        self.basketBtn.isHidden = true
                        self.viewCounInBasket.isHidden = false
                        
                        
                        self.selectPortion.accept(item.portion)
                        return
                    }
                }
            }
            if let self = self{
                self.idDishInBasket = nil
                self.countProductInBasket = 0
                self.aboutDishBasketDelegate?.inBasket(count: self.countProductInBasket)
                self.countProtuct.text = "\(self.countProductInBasket)"
                self.basketBtn.isHidden = false
                self.viewCounInBasket.isHidden = true
                
            }
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
    }
    
    
    //MARK:- request AddFavorite
    private func requestAddFavorite(at idDish: Int){
        dishShowWaitOverlay()
        WishlishAPI.requstObjectWishlist(type: BaseResponseModel.self, request: .addWishlist(dish_id: idDish), delegate: delegate) { [weak self] (value) in
            self?.dishRemoveWaitOverlay()
            if let responce = value{
                if let success = responce.success, success{
                    //устанавливаем картинку favorite
                    self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_red"), for: .normal)
                    self?.dish.wishlist = .favorite
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logOut()
                    }
                    //устанавливаем картинку unFavorite
                    self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_unselect"), for: .normal)
                    self?.dish.wishlist = .unFavorite
                }
            }else{
                //устанавливаем картинку unFavorite
                self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_unselect"), for: .normal)
                self?.dish.wishlist = .unFavorite
            }
            self?.updateFavoritesDish()
        }
    }
    
    //MARK:- Remove from Favorites
    private func requestRemoveFromFavotite(at idDish: Int){
        dishShowWaitOverlay()
        WishlishAPI.requstObjectWishlist(type: BaseResponseModel.self, request: .removeWishlist(dish_id: idDish), delegate: delegate) { [weak self] (value) in
            self?.dishRemoveWaitOverlay()
            if let responce = value{
                if let success = responce.success, success{
                    //устанавливаем картинку unFavorite
                    self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_unselect"), for: .normal)
                    self?.dish.wishlist = .unFavorite
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logOut()
                    }
                    //устанавливаем картинку favorite
                    self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_red"), for: .normal)
                    self?.dish.wishlist = .favorite
                }
            }else{
                //устанавливаем картинку favorite
                self?.favoriteBtn.setImage(UIImage(named: "ic_favorites_red"), for: .normal)
                self?.dish.wishlist = .favorite
            }
            self?.updateFavoritesDish()
        }
    }
    
    //MARK:- request AddBasket
    private func requestAddDishInBasket(){
        guard let idDish = dish.id, let idPortion = self.selectPortion.value?.id else{
            self.tabBarVC.basketModel.accept(self.tabBarVC.basketModel.value)
            return
        }
        
        BasketAPI.requstObjectBasket(type: BasketDataModel.self, request: .addDishInBasket(dish_id: idDish, portion_id: idPortion, quantity: countProductInBasket), delegate: delegate) { [weak self] (value, isCancel) in
            if let responce = value{
                if let success = responce.success, success{
                    self?.tabBarVC.basketModel.accept(responce.data)
                    
                    for item in responce.data?.items ?? []{
                        if item.dish?.id == idDish, let count = item.quantity, count == 1{
                            self?.showAlertDishInBasket()
                            break
                        }
                    }

                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logOut()
                    }else{
                        if isCancel{
                            return
                        }
                        
                        if let error = responce.error{
                            self?.alertWarning(title: "Ошибка", message: error)
                        }
                        self?.tabBarVC.basketModel.accept(self?.tabBarVC.basketModel.value)
                    }
                }
            }
        }
    }
    
    //MARK:- Request Quantity
    private func requestQuantityDishInBasket(){
        guard let idDishInBasket = self.idDishInBasket else {
            self.tabBarVC.basketModel.accept(self.tabBarVC.basketModel.value)
            return
        }
        
        BasketAPI.requstObjectBasket(type: BasketDataModel.self, request: .chageQuantity(item_id: idDishInBasket, quantity: countProductInBasket), delegate: delegate) { [weak self] (value, isCancel) in
            if let responce = value{
                if let success = responce.success, success{
                    self?.tabBarVC.basketModel.accept(responce.data)
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logOut()
                    }else{
                        if isCancel{
                            return
                        }
                        if let error = responce.error{
                            self?.alertWarning(title: "Ошибка", message: error)
                        }
                        self?.tabBarVC.basketModel.accept(self?.tabBarVC.basketModel.value)
                    }
                }
            }
        }
    }
    
    private func alertWarning(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func updateFavoritesDish(){
        WishlishAPI.requstObjectWishlist(type: MenuSectionsModel.self, request: .getWishlist, delegate: delegate) { [weak self] (value) in
            if let menuSection = value{
                if let success = menuSection.success, success{
                    self?.favoritesDish.accept(menuSection)
                    print()
                }
            }
        }
    }
    
    
    private func showAlertDishInBasket(){
        //показываем алерт товар добавлен в корзину
        let alert = UIView.viewFromNibName(name: "AlertAddInBasket") as! UIViewDesignable
        alert.center.x = self.view.frame.width / 2.0
        alert.center.y = self.view.frame.height / 3.0 + 88.0
        self.view.addSubview(alert)
        
        
        alert.alpha = 1.0
        UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut, animations: {
            alert.alpha = 0.0
        }) { (_) in
            alert.removeFromSuperview()
        }
    }
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share(_ sender: UIButton) {
        print("share")
    }
    @IBAction func favorite(_ sender: UIButton) {
        if let id = dish.id{
            let generator = UINotificationFeedbackGenerator()
            if dish.wishlist == .unFavorite{
                //устанавливаем блюдо в избранное
                requestAddFavorite(at: id)
                generator.notificationOccurred(.success)
            }else{
                //убираем блюдо из избранного
                requestRemoveFromFavotite(at: id)
                generator.notificationOccurred(.success)
            }
        }
    }
    
    @IBAction func addBasket(_ sender: UIButton) {
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        countProductInBasket += 1
        aboutDishBasketDelegate?.inBasket(count: countProductInBasket)
        
        countProtuct.text = "\(countProductInBasket)"
        
        basketBtn.isHidden = true
        viewCounInBasket.isHidden = false
        
        //запрос на сервер
        requestAddDishInBasket()
        
    }
    
    @IBAction func minusFromBasket(_ sender: UIButton) {
        countProductInBasket -= 1
        aboutDishBasketDelegate?.inBasket(count: countProductInBasket)
        countProtuct.text = "\(countProductInBasket)"
        
        requestQuantityDishInBasket()
        
        if countProductInBasket == 0{
            basketBtn.isHidden = false
            viewCounInBasket.isHidden = true
        }
    }
    
    @IBAction func plusFromBasket(_ sender: UIButton) {
        countProductInBasket += 1
        aboutDishBasketDelegate?.inBasket(count: countProductInBasket)
        countProtuct.text = "\(countProductInBasket)"
        
        requestQuantityDishInBasket()
    }
    
    //MARK:- deinit
    deinit{
        print("DishMainViewController is deinit")
    }
    
}

extension DishMainViewController: DishMainViewDelegate{
    
    func dishShowWaitOverlay() {
        self.showWaitOverlay()
    }
    
    func dishRemoveWaitOverlay() {
        self.removeAllOverlays()
    }
    
    func logOut() {
        self.catMenuMainDelegate?.logOut()
    }
    
}
