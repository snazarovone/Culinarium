//
//  MenuViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 16.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SwiftOverlays
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchView: UIViewDesignable!
    @IBOutlet weak var bottomConstaintSearchView: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var underSearchView: UIView! //isHide default
    
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTF: UITextFieldDesignable!
    @IBOutlet weak var titleMenu: UILabel!
    
    private var menuViewModel: MenuViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configKeyboard()
        
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController,
            let menuSections = tabBarVC.menuSections{
            menuViewModel = MenuViewModel(menuSection: menuSections)
        }else{
            menuViewModel = MenuViewModel()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- Favorites Dish
    private func getFavoritesDish() -> BehaviorRelay<MenuSectionsModel?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.favoritesDish
        }else{
            let model: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
            return model
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
    
    //MARK:- UserInfo
    private func getUserInfo() -> BehaviorRelay<UserInfo?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.userInfo
        }else{
            let model: BehaviorRelay<UserInfo?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    
    //MARK:- Request Search
    private func requestSearchDish(titleDish: String){
        guard titleDish.isEmpty == false else {return}
        
        menuViewModel.requestSearchDish(from: titleDish) { [weak self] (result) in
            switch result{
            case .complite:
                //обновляем таблицу поиска
                self?.searchTableView.reloadData()
            case .error:
                if (self?.menuViewModel.getAuth()) != nil{
                    //удаляем данные авторизации
                    //Открыть форму авторизации
                    //проверил
                    self?.logout()
                }
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func search(_ sender: UIButton){
        searchTF.becomeFirstResponder()
    }
    
    @IBAction func closeSearch(_ sender: UIButton){
        dismissKeyboard()
    }
    
    @IBAction func favoritesDishes(_ sender: UIButton){
        performSegue(withIdentifier: SegueID.favorites.id, sender: nil)
    }
    
    @IBAction func help_callBack(_ sender: UIButton){
        performSegue(withIdentifier: SegueID.feedback.id, sender: nil)
    }
    
    //MARK:- OpenCatMenu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.catMenu.id{
            if let dvc = segue.destination as? CatMenuMainViewController, let data = sender as? MenuSection, data.categories != nil, data.categories?.count ?? 0 > 0{
                dvc.menuSection = data
                dvc.menuViewControllerDelegate = self
                dvc.favoritesDish = getFavoritesDish()
            }
            return
        }
        
        //MARK:- Search List Dishes
        if let identifier = segue.identifier, identifier == SegueID.searchMenu.id{
            if let dvc = segue.destination as? SearchMenuViewController{
                dvc.searchMenuViewModel = SearchMenuViewModel(dishes: self.menuViewModel.getSearchEatModel())
                dvc.catMenuMainDelegate = self
                dvc.favoritesDish = getFavoritesDish()
                dvc.userInfo = getUserInfo()
                dvc.listCafe = getListCafe()
                dvc.dishesMainInfo = getAllDish()
            }
            return
        }
        
        //MARK:- Show About Dish
        if let identifier = segue.identifier, identifier == SegueID.aboutDishMain.id{
            if let dvc = segue.destination as? DishMainViewController{
                dvc.dish = sender as? DisheModel
                dvc.catMenuMainDelegate = self
                dvc.favoritesDish = getFavoritesDish()
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
    }
    
    
    //MARK:- deinit
    deinit {
        print("MenuViewController is deinit")
    }
}

//MARK:- TableView
extension MenuViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return self.menuViewModel.nemberOfRow(in: section)
        }else{
            return self.menuViewModel.searchNumberOfRow(in: section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView{
            let cellData = self.menuViewModel.cellForRow(at: indexPath)
            switch cellData.typeCell {
            case .left:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellID.menuLeftContaint.identifire) as! MenuLeftContaintTableViewCell
                cell.dataMenu = cellData
                return cell
            case .right:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellID.menuRightContaint.identifire) as! MenuRightContaintTableViewCell
                cell.dataMenu = cellData
                return cell
            }
        }else{
            //поиск
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.searchCell.identifire) as! SearchTableViewCell
            cell.dataSearch = self.menuViewModel.searchCellForRow(at: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView{
            DispatchQueue.main.async {
                guard let idSection = self.menuViewModel.sectionId(at: indexPath) else{
                    return
                }
                //request
                self.showWaitOverlay()
                self.view.isUserInteractionEnabled = false
                self.menuViewModel.getAllCatSelect(at: idSection) { [weak self] (requestComplite, catSectionMenu) in
                    self?.removeAllOverlays()
                    self?.view.isUserInteractionEnabled = true
                    
                    switch requestComplite{
                    case .complite:
                        if catSectionMenu?.categories != nil && catSectionMenu?.categories?.count ?? 0 > 0{
                            self?.performSegue(withIdentifier: SegueID.catMenu.id, sender: catSectionMenu)
                        }
                    case .error:
                        if (self?.menuViewModel.getAuth()) != nil{
                            //удаляем данные авторизации
                            //Открыть форму авторизации
                            //проверил
                            self?.logout()
                        }
                    }
                }
            }
        }else{
            //поиск
            DispatchQueue.main.async {
                self.dismissKeyboard()
                self.performSegue(withIdentifier: SegueID.aboutDishMain.id, sender: self.menuViewModel.getSearchEatModel(at: indexPath))
            }
        }
    }
    
}

extension MenuViewController: UITextFieldDelegate{
    fileprivate func configKeyboard(){
        registerForKeyboardNotification()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTF.borderC = UIColor(named: "Black282A2F")!
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true}
        requestSearchDish(titleDish: currentText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //поиск
        DispatchQueue.main.async {
            self.dismissKeyboard()
            self.performSegue(withIdentifier: SegueID.searchMenu.id, sender: nil)
        }
        return true
    }
    
    
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification){
        let userInfo = notification.userInfo!
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        let indexPath = IndexPath(row: 0, section: 0)
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
        
        self.tableViewTopConstraint.constant = -64.0
        self.bottomConstaintSearchView.constant = keyboardFrame.height - 44.0
        self.searchView.alpha = 0.0
        self.underSearchView.isHidden = false
        self.heartBtn.alpha = 1.0
        self.callBtn.alpha = 1.0
        self.titleMenu.alpha = 1.0
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { [weak self] in
                        if let self = self{
                            self.view.layoutIfNeeded()
                            self.searchView.alpha = 1.0
                            self.heartBtn.alpha = 0.0
                            self.callBtn.alpha = 0.0
                            self.titleMenu.alpha = 0.0
                        }
            },
                       completion: {(_) in
                        
                        
        })
    }
    
    @objc func kbWillHide(_ notification: Notification){
        let userInfo = notification.userInfo!
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        self.tableViewTopConstraint.constant = 0.0
        self.bottomConstaintSearchView.constant = 0.0
        self.searchView.alpha = 1.0
        self.underSearchView.isHidden = true
        self.heartBtn.alpha = 0.0
        self.callBtn.alpha = 0.0
        self.titleMenu.alpha = 0.0
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { [weak self] in
                        if let self = self{
                            self.view.layoutIfNeeded()
                            self.searchView.alpha = 0.0
                            self.heartBtn.alpha = 1.0
                            self.callBtn.alpha = 1.0
                            self.titleMenu.alpha = 1.0
                        }
            },
                       completion: { (_) in
        })
    }
    
    func removeNotificationKeyBoard(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
}

//MARK:- Logout
extension MenuViewController: MenuViewControllerDelegate{
    func logout() {
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            tabBarVC.removeDataAuth()
            tabBarVC.logout()
        }
    }
}

extension MenuViewController: CatMenuMainDelegate{
    func showOverlay() {
        self.showWaitOverlay()
    }
    
    func removeOverlay() {
        self.removeAllOverlays()
    }
    
    func logOut() {
        self.logout()
    }
}
