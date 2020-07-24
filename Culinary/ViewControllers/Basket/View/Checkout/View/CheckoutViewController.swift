//
//  CheckoutViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 25.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftOverlays

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var underPicker: UIView! //default alpha == 0
    @IBOutlet weak var pickerView: UIView! //hide is default
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeTF: UITextFieldDesignable!
    @IBOutlet weak var phoneTF: UITextFieldDesignable!
    @IBOutlet weak var nameTF: UITextFieldDesignable!
    
    @IBOutlet var filds: [UITextFieldDesignable]!
    @IBOutlet weak var deliveryBtn: UIButtonDesignable!
    @IBOutlet weak var pickupBtn: UIButtonDesignable!
    @IBOutlet weak var listMyAddressView: UIViewDesignable!
    @IBOutlet weak var heightListMyAddress: NSLayoutConstraint!
    @IBOutlet weak var underViewSelectAddress: UIView!
    
    
    //Адрес доставка
    @IBOutlet weak var selectSaveAddressView: UIView!
    @IBOutlet weak var stackAddress1: UIStackView!
    @IBOutlet weak var stackAddress2: UIStackView!
    @IBOutlet weak var titleSave: UILabel!
    @IBOutlet weak var removeSelectedAddressBtn: UIButton! //hide when UNselected save address
    @IBOutlet weak var arrowDown: UIImageView! //hide when selected save address
    
    
    //самовывоз
    @IBOutlet weak var pickupView: UIView! //hide if delivery
    @IBOutlet weak var nameCafeTF: UITextFieldDesignable!
    
    //payments
    @IBOutlet weak var cashBtn: UIButtonDesignable!
    @IBOutlet weak var onlineCardsBtn: UIButtonDesignable!
    @IBOutlet weak var viewCash: UIView! // isHide when onlineCards
    @IBOutlet weak var titleCashDelivery: UILabel! // isHide when onlineCards
    
    @IBOutlet weak var netxtBtn: UIButtonDesignable!
    
    //Constraints
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var tapToUnder: UITapGestureRecognizer!
    private var tapToUnderSelectAddress: UITapGestureRecognizer!
    private var tap: UITapGestureRecognizer!
    private var isShowPicker = false
    private var centerViewDefault: CGFloat = 0.0
    private let disposeBag = DisposeBag()
    private weak var tabBarVC: TabBarViewController!
    
    //PUBLIC
    public var checkoutViewModel: CheckoutViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTabBarVC()
        heightListMyAddress.constant = 0.0
        configKeyboard()
        isNextBtn(textField: nil, valueTF: nil)
        
        subscribes()
        
        tapToUnder = UITapGestureRecognizer(target: self, action: #selector(self.underTap))
        tapToUnder.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        underPicker.addGestureRecognizer(tapToUnder)
        
        tapToUnderSelectAddress = UITapGestureRecognizer(target: self, action: #selector(self.underTapSelectAddress))
        tapToUnderSelectAddress.delegate = self
        tapToUnderSelectAddress.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        underViewSelectAddress.addGestureRecognizer(tapToUnderSelectAddress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        if self.checkoutViewModel.checkExistAddress(street: self.filds[CheckoutFilds.street.tag].text, house: self.filds[CheckoutFilds.house.tag].text, porch: self.filds[CheckoutFilds.porch.tag].text, flat: self.filds[CheckoutFilds.flat.tag].text, floor: self.filds[CheckoutFilds.floor.tag].text, doorCode: self.filds[CheckoutFilds.door_code.tag].text){
            self.setValueFildsAddress()
        }
        
        limitPickerView()
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
    
    //MARK:- Subscribes
    private func subscribes(){
        checkoutViewModel.userInfo.asObservable().subscribe(onNext: { [weak self] (value) in
            
            //имя
            self?.filds?[CheckoutFilds.name.tag].text = value?.name
            
            //телефон
            self?.filds?[CheckoutFilds.phone.tag].text = self?.checkoutViewModel.phoneUser
            if let phoneUser = self?.filds?[CheckoutFilds.phone.tag].text, phoneUser.trimmingCharacters(in: .whitespacesAndNewlines).count == 17{
                self?.filds?[CheckoutFilds.phone.tag].isUserInteractionEnabled = false
            }else{
                self?.filds?[CheckoutFilds.phone.tag].isUserInteractionEnabled = true
            }
            
            self?.isNextBtn(textField: nil, valueTF: nil)
            
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        checkoutViewModel.myAddresses.asObservable().subscribe(onNext: { [weak self] (_) in
            if self?.checkoutViewModel.checkExistAddress(street: self?.filds[CheckoutFilds.street.tag].text, house: self?.filds[CheckoutFilds.house.tag].text, porch: self?.filds[CheckoutFilds.porch.tag].text, flat: self?.filds[CheckoutFilds.flat.tag].text, floor: self?.filds[CheckoutFilds.floor.tag].text, doorCode: self?.filds[CheckoutFilds.door_code.tag].text) ?? false{
                self?.setValueFildsAddress()
            }
            
            if self?.checkoutViewModel?.checkExistSelectedAddress() ?? false{
                self?.setValueFildsAddress()
            }else{
                self?.unSelectedValueFildsAddress()
            }
            //скрываем поле выбора адреса если нет сохраненных адресов
            if (self?.checkoutViewModel.numberOfRow() ?? 0) == 0{
                self?.selectSaveAddressView.isHidden = true
            }else{
                self?.selectSaveAddressView.isHidden = false
            }
            
            
            self?.isNextBtn(textField: nil, valueTF: nil)
            self?.tableView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    
    //MARK:- Request ChekcoutOrder
    private func requestCheckoutOrder(){
        var floor: Int? = nil
        var exchange: Int? = nil
        
        var time: String = getDateInFormat(date: nil)
        if let text = filds![CheckoutFilds.time.tag].text, text.uppercased() != "Сейчас".uppercased(){
            time = text
        }
        
        if let text = filds?[CheckoutFilds.floor.tag].text{
            floor = Int(text.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        if let text = filds?[CheckoutFilds.exchange.tag].text{
            exchange = Int(text.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        let name = nameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = phoneTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let title = filds?[CheckoutFilds.titleAddress.tag].text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let street = filds?[CheckoutFilds.street.tag].text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let house = filds?[CheckoutFilds.house.tag].text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let porch = filds?[CheckoutFilds.porch.tag].text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let flat = filds?[CheckoutFilds.flat.tag].text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let door_code = filds?[CheckoutFilds.door_code.tag].text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        checkoutViewModel.requestCheckoutOrder(name: name, phone: phone, time: time, title: title, street: street, house: house, porch: porch, flat: flat, door_code: door_code, floor: floor, exchange: exchange) { [weak self] (result) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            switch result{
            case .complite:
                self?.tabBarVC.splashViewDelegate?.requestMyAddresses()
                self?.tabBarVC.splashViewDelegate?.requestUserInfo()
                self?.performSegue(withIdentifier: SegueID.totalCheckout.id, sender: nil)
            case .error:
                if self?.checkoutViewModel.getAuth() != nil{
                    //открываем форму регистрации
                    self?.tabBarVC.removeDataAuth()
                    self?.tabBarVC.logout()
                }else{
                    self?.alertWarning()
                }
            }
        }
    }
    
    private func alertWarning(){
        let alert = UIAlertController(title: "Ошибка", message: "Во время выполнения запроса произошла ошибка. Пожалуйста, попробуйте позднее", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- TimeView
    private func hidePicker(){
        isShowPicker = false
        
        bottomConstraint.constant = -256.0
        underPicker.alpha = 1.0
        tapToUnder.isEnabled = false
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.pickerView.isHidden = false
            self.underPicker.alpha = 0.0
        }
    }
    
    //MARK:- Limit PickerView
    private func limitPickerView(){
        let calendar = Calendar.current
        let minDateComponent = calendar.dateComponents([.day,.month,.year, .hour, .minute], from: Date())

        let minDate = calendar.date(from: minDateComponent)
        print(" min date : \(String(describing: minDate))")

        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        maxDateComponent.day = (maxDateComponent.day ?? 0) + 3

        let maxDate = calendar.date(from: maxDateComponent)
        print("max date : \(String(describing: maxDate))")

        datePicker.minimumDate = minDate! as Date
        datePicker.maximumDate =  maxDate! as Date
    }
    
    private func showSelectTimeView(){
        isShowPicker = true
        dismissKeyboard()
        
        bottomConstraint.constant = CGFloat(0.0)
        underPicker.alpha = 0.0
        tapToUnder.isEnabled = true
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.pickerView.isHidden = false
            self.underPicker.alpha = 1.0
        }
    }
    
    private func showMyAddressListView(){
        dismissKeyboard()
        tapToUnderSelectAddress.isEnabled = true
        underViewSelectAddress.alpha = 0.0
        heightListMyAddress.constant = checkoutViewModel.heightListMyAddress
        UIView.animate(withDuration: 0.7) {
            self.view.layoutIfNeeded()
            self.underViewSelectAddress.alpha = 1.0
        }
    }
    
    private func hideMyAddressListView(){
         heightListMyAddress.constant = 0
         tapToUnderSelectAddress.isEnabled = false
         underViewSelectAddress.alpha = 1.0
         UIView.animate(withDuration: 0.7) {
             self.view.layoutIfNeeded()
             self.underViewSelectAddress.alpha = 0.0
         }
     }
    
    //MARK: Address Fields
    private func setValueFildsAddress(){
        arrowDown.isHidden = true
        removeSelectedAddressBtn.isHidden = false
        
        filds?[CheckoutFilds.selectAddress.tag].text = checkoutViewModel.titleSelectAddress
        filds?[CheckoutFilds.street.tag].text = checkoutViewModel.street
        filds?[CheckoutFilds.house.tag].text = checkoutViewModel.house
        filds?[CheckoutFilds.porch.tag].text = checkoutViewModel.porch
        filds?[CheckoutFilds.flat.tag].text = checkoutViewModel.flat
        filds?[CheckoutFilds.floor.tag].text = checkoutViewModel.floor
        filds?[CheckoutFilds.door_code.tag].text = checkoutViewModel.doorcode
        
        
        filds?[CheckoutFilds.street.tag].isUserInteractionEnabled = false
        filds?[CheckoutFilds.house.tag].isUserInteractionEnabled = false
        filds?[CheckoutFilds.porch.tag].isUserInteractionEnabled = false
        filds?[CheckoutFilds.flat.tag].isUserInteractionEnabled = false
        filds?[CheckoutFilds.floor.tag].isUserInteractionEnabled = false
        filds?[CheckoutFilds.door_code.tag].isUserInteractionEnabled = false
        
        titleSave.isHidden = true
        if checkoutViewModel.deliveryType == .courier{
            filds?[CheckoutFilds.titleAddress.tag].isHidden = true
        }
    }
    
    //MARK: Address Fields
    private func unSelectedValueFildsAddress(){
        arrowDown.isHidden = false
        removeSelectedAddressBtn.isHidden = true
        
        filds?[CheckoutFilds.selectAddress.tag].text = "Выбрать из сохраненных"
        filds?[CheckoutFilds.street.tag].text = ""
        filds?[CheckoutFilds.house.tag].text =  ""
        filds?[CheckoutFilds.porch.tag].text = ""
        filds?[CheckoutFilds.flat.tag].text = ""
        filds?[CheckoutFilds.floor.tag].text = ""
        filds?[CheckoutFilds.door_code.tag].text = ""
        filds?[CheckoutFilds.titleAddress.tag].text = ""
        
        
        filds?[CheckoutFilds.street.tag].isUserInteractionEnabled = true
        filds?[CheckoutFilds.house.tag].isUserInteractionEnabled = true
        filds?[CheckoutFilds.porch.tag].isUserInteractionEnabled = true
        filds?[CheckoutFilds.flat.tag].isUserInteractionEnabled = true
        filds?[CheckoutFilds.floor.tag].isUserInteractionEnabled = true
        filds?[CheckoutFilds.door_code.tag].isUserInteractionEnabled = true
        
        titleSave.isHidden = false
        
        if checkoutViewModel.deliveryType == .courier{
            filds?[CheckoutFilds.titleAddress.tag].isHidden = false
        }
        
        isNextBtn(textField: nil, valueTF: nil)
    }
    
    private func getDateInFormat(date: Date?) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = date{
            return dateFormatter.string(from: date)
        }else{
            return dateFormatter.string(from: Date())
        }
    }
    
    //MARK:- Actions
    @IBAction func next(_ sender: UIButton){
        dismissKeyboard()
        
        if self.checkoutViewModel.checkExistAddress(street: self.filds[CheckoutFilds.street.tag].text, house: self.filds[CheckoutFilds.house.tag].text, porch: self.filds[CheckoutFilds.porch.tag].text, flat: self.filds[CheckoutFilds.flat.tag].text, floor: self.filds[CheckoutFilds.floor.tag].text, doorCode: self.filds[CheckoutFilds.door_code.tag].text){
            self.setValueFildsAddress()
        }
        
        
        requestCheckoutOrder()
    }
    
    @objc func underTap(){
        hidePicker()
    }
    
    @objc func underTapSelectAddress(){
        hideMyAddressListView()
    }
    
    @IBAction func selectTime(_ sender: UIButton) {
        showSelectTimeView()
    }
    @IBAction func readyDate(_ sender: UIButton) {
        hidePicker()
    }
    @IBAction func datePic(_ sender: UIDatePicker) {
        timeTF.text = getDateInFormat(date: sender.date)
    }
    
    @IBAction func editPhone(_ sender: UIButton) {
        filds[CheckoutFilds.phone.tag].isUserInteractionEnabled = true
        filds[CheckoutFilds.phone.tag].becomeFirstResponder()
    }
    
    @IBAction func removeSelectedAddress(_ sender: UIButton) {
    }
    
    @IBAction func selectCafe(_ sender: UIButton) {
        performSegue(withIdentifier: SegueID.cafePlaces.id, sender: nil)
    }
    
    
    //MARK:- Delivery
    @IBAction func delivery(_ sender: UIButtonDesignable) {
        checkoutViewModel.deliveryType = .courier
        dismissKeyboard()
        isNextBtn(textField: nil, valueTF: nil)
        
        pickupView.isHidden = true
        selectSaveAddressView.isHidden = false
        filds?[CheckoutFilds.street.tag].isHidden = false
        stackAddress1.isHidden = false
        stackAddress2.isHidden = false
        titleSave.isHidden = false
        if checkoutViewModel.idSelectedAddress == nil{
            titleSave.isHidden = false
            filds?[CheckoutFilds.titleAddress.tag].isHidden = false
        }else{
            titleSave.isHidden = true
            filds?[CheckoutFilds.titleAddress.tag].isHidden = true
        }
        
        
        pickupBtn.backgroundColor = .clear
        pickupBtn.setTitleColor(UIColor(named: "Gray5D5956")!, for: .normal)
        
        deliveryBtn.backgroundColor = UIColor(named: "Gray_D4D0CD")!
        deliveryBtn.setTitleColor(UIColor(named: "Black282A2F")!, for: .normal)
        
        //скрываем поле выбора адреса если нет сохраненных адресов
        if self.checkoutViewModel.numberOfRow() == 0{
            self.selectSaveAddressView.isHidden = true
        }else{
            self.selectSaveAddressView.isHidden = false
        }
    }
    
    @IBAction func pickup(_ sender: UIButtonDesignable) {
        checkoutViewModel.deliveryType = .pickup
        dismissKeyboard()
        heightListMyAddress.constant = 0.0
        isNextBtn(textField: nil, valueTF: nil)
        
        pickupView.isHidden = false
        selectSaveAddressView.isHidden = true
        filds?[CheckoutFilds.street.tag].isHidden = true
        stackAddress1.isHidden = true
        stackAddress2.isHidden = true
        titleSave.isHidden = true
        filds?[CheckoutFilds.titleAddress.tag].isHidden = true
        
        pickupBtn.backgroundColor = UIColor(named: "Gray_D4D0CD")!
        pickupBtn.setTitleColor(UIColor(named: "Black282A2F")!, for: .normal)
        
        deliveryBtn.backgroundColor = .clear
        deliveryBtn.setTitleColor(UIColor(named: "Gray5D5956")!, for: .normal)
        
        if checkoutViewModel.idSelectCafe == nil{
            nameCafeTF?.text = "Выберите кафе"
            performSegue(withIdentifier: SegueID.cafePlaces.id, sender: nil)
        }
    }
    
    @IBAction func selectedAddress(_ sender: UIButton) {
        if checkoutViewModel.idSelectedAddress != nil{
            checkoutViewModel.removeSelectedAddress()
            unSelectedValueFildsAddress()
        }else{
            showMyAddressListView()
        }
    }
    
    //MARK:- Payment
    @IBAction func cash(_ sender: UIButtonDesignable) {
        checkoutViewModel.paymentType = .cash
        filds?[CheckoutFilds.exchange.tag].becomeFirstResponder()
        isNextBtn(textField: nil, valueTF: nil)
        
        viewCash.isHidden = false
        titleCashDelivery.isHidden = false
        
        sender.backgroundColor = UIColor(named: "Gray_D4D0CD")!
        sender.setTitleColor(UIColor(named: "Black282A2F")!, for: .normal)
        
        onlineCardsBtn.backgroundColor = .clear
        onlineCardsBtn.setTitleColor(UIColor(named: "Gray5D5956")!, for: .normal)
    }
    
    @IBAction func onlineCards(_ sender: UIButtonDesignable) {
        checkoutViewModel.paymentType = .online
        dismissKeyboard()
        isNextBtn(textField: nil, valueTF: nil)
        
        viewCash.isHidden = true
        titleCashDelivery.isHidden = true
        
        sender.backgroundColor = UIColor(named: "Gray_D4D0CD")!
        sender.setTitleColor(UIColor(named: "Black282A2F")!, for: .normal)
        
        cashBtn.backgroundColor = .clear
        cashBtn.setTitleColor(UIColor(named: "Gray5D5956")!, for: .normal)
    }
    
      
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- list cafe
        if let identifier = segue.identifier, identifier == SegueID.cafePlaces.id{
            if let dvc = segue.destination as? CafePlacesViewController{
                dvc.cafePlacesViewModel = CafePlacesViewModel(listCafe: self.checkoutViewModel.listCafe)
                dvc.didSelectCafe = {
                    [checkoutViewModel, nameCafeTF, isNextBtn] id in
                    checkoutViewModel?.idSelectCafe = id
                    nameCafeTF?.text = checkoutViewModel?.nameSelectCafe()
                    isNextBtn(nil, nil)
                }
            }
            return
        }
        if let identifier = segue.identifier, identifier == SegueID.totalCheckout.id{
            if let dvc = segue.destination as? TotalCheckoutViewController{
                dvc.totalCheckoutViewModel = TotalCheckoutViewModel(basketCheckout: checkoutViewModel.basketCheckout)
            }
            return
        }
        
    }
    
    
    //MARK:- Validation Data
    private func validData(textField: UITextField?, valueTF: String?) -> (Bool){
    
        //имя
        if textField != filds![CheckoutFilds.name.tag]{
            if let text = filds![CheckoutFilds.name.tag].text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
            }else{
                return false
            }
        }else{
            if let text = valueTF, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
            }else{
                return false
            }
        }
        
        //телефон
        if textField != filds![CheckoutFilds.phone.tag]{
            if let text = filds![CheckoutFilds.phone.tag].text, text.trimmingCharacters(in: .whitespacesAndNewlines).count == 17{
            }else{
                return false
            }
        }else{
            if let text = valueTF, text.trimmingCharacters(in: .whitespacesAndNewlines).count == 17{
            }else{
                return false
            }
        }
        
        //способы доставки
        if checkoutViewModel.deliveryType == .courier{
            if checkoutViewModel.idSelectedAddress != nil{
            }else{
                //улица
                if textField != filds![CheckoutFilds.street.tag]{
                    if let text = filds![CheckoutFilds.street.tag].text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                    }else{
                        return false
                    }
                }else{
                    if let text = valueTF, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                    }else{
                        return false
                    }
                }
                
                //дом
                if textField != filds![CheckoutFilds.house.tag]{
                    if let text = filds![CheckoutFilds.house.tag].text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                    }else{
                        return false
                    }
                }else{
                    if let text = valueTF, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                    }else{
                        return false
                    }
                }
            }
        }else{
            if checkoutViewModel.idSelectCafe != nil{
            }else{
                return false
            }
        }
        
        return true
    }
    
    private func isNextBtn(textField: UITextField?, valueTF: String?){
        if validData(textField: textField, valueTF: valueTF){
            netxtBtn.alpha = 1.0
            netxtBtn.isUserInteractionEnabled = true
            netxtBtn.setTitleColor(.black, for: .normal)
        }else{
            netxtBtn.alpha = 0.5
            netxtBtn.isUserInteractionEnabled = false
            netxtBtn.setTitleColor(.gray, for: .normal)
        }
    }
    
    
    //MARK:- deinit
    deinit{
        print("CheckoutViewController is deinit")
    }
}


//MARK:- TableView
extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.saveAddress.identifire) as! SaveAddressTableViewCell
        cell.dataSaveAddress = checkoutViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkoutViewModel.didSelect(at: indexPath)
        setValueFildsAddress()
        hideMyAddressListView()
        isNextBtn(textField: nil, valueTF: nil)
    }
    
    
}

//MARK:- TextFields Delegate
extension CheckoutViewController: UITextFieldDelegate{
    fileprivate func configKeyboard(){
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        view.addGestureRecognizer(tap)
        registerForKeyboardNotification()
    }
    
    @objc func dismissKeyboard() {
        if heightListMyAddress.constant > 0{
            hideMyAddressListView()
        }
        selectTextField()
        view.endEditing(true)
        tap.isEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectTextField()
        tap.isEnabled = true
        startPhone(textField: textField)
        (textField as! UITextFieldDesignable).borderC = UIColor(named: "RedA4262A")!
        
        if textField == filds![CheckoutFilds.exchange.tag]{
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == filds![CheckoutFilds.exchange.tag], textField.text == ""{
            textField.text = "0"
        }
    }
    
    private func startPhone(textField: UITextField){
        if  textField == phoneTF && textField.text == ""{
            textField.text = checkoutViewModel.formattedNumber(number: "7")
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true}
        
        isNextBtn(textField: textField, valueTF: currentText)
        if textField == phoneTF{
            textField.text = checkoutViewModel.formattedNumber(number: currentText)
            startPhone(textField: textField)
            return false
            
        }else{
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF && phoneTF.isUserInteractionEnabled == true{
            phoneTF.becomeFirstResponder()
        }else{
            if textField == filds![CheckoutFilds.street.tag]{
                filds![CheckoutFilds.house.tag].becomeFirstResponder()
            }else{
                if textField == filds![CheckoutFilds.house.tag]{
                     filds![CheckoutFilds.porch.tag].becomeFirstResponder()
                }else{
                    if textField == filds![CheckoutFilds.door_code.tag]{
                        filds![CheckoutFilds.titleAddress.tag].becomeFirstResponder()
                    }else{
                        dismissKeyboard()
                    }
                }
            }
        }
        return true
    }
    
    fileprivate func selectTextField(){
        // выделить заполненные поля
        for tf in filds{
            if tf.text == ""{
                tf.borderC = UIColor(named: "Brown_B8B1AB_60")!
            }else{
                tf.borderC = UIColor(named: "Brown_B8B1AB_60")!
            }
        }
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

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { [weak self] in
                        if let self = self{
                            self.view.layoutIfNeeded()
                        }
            },
                       completion: { (_) in
                        
                        
        })
    }
    
    @objc func kbWillHide(_ notification: Notification){
        guard isShowPicker == false else {
            return
        }
        
        let userInfo = notification.userInfo!
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        scrollView.contentOffset = CGPoint.zero
        scrollView.contentInset =  UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { [weak self] in
                        if let self = self{
                            self.view.layoutIfNeeded()
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

extension CheckoutViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.tableView) == true{
            return false
        }
        return true
    }
}
