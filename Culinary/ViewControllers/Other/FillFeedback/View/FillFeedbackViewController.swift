//
//  FillFeedbackViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Photos
import Cosmos
import SwiftOverlays

class FillFeedbackViewController: UIViewController {
    
    @IBOutlet weak var feedTypeCollectionView: UICollectionView!
    @IBOutlet weak var addImagesCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Личная информация
    @IBOutlet var personalInfoTF : [UITextFieldDesignable]!
    
    //Комментарий
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentView: UIViewDesignable!
    @IBOutlet weak var emptyTF: UITextField!
    
    @IBOutlet weak var rating: CosmosView!
    
    //тип меню
    @IBOutlet weak var titleMenuType: UILabel!
    @IBOutlet weak var descriptionMenuType: UITextField!
    @IBOutlet weak var markOnMapMenuTypeBtn: UIButton! // only hide
    @IBOutlet weak var viewMenuType: UIView! // hide/show
    
    //PUBLIC
    public var fillFeedbackViewModel = FillFeedbackViewModel(selectHeader: nil, listCafe: BehaviorRelay(value: nil), idSelectCafe: nil, idSelectDish: nil, userInfo: BehaviorRelay(value: nil), dishesMainInfo: BehaviorRelay(value: []))
    
    //для выхода из аккаунта требуется один из делегатов
    public var aboutCafeDelegate: AboutCafeDelegate?
    public var otherViewControllerDelegate: OtherViewControllerDelegate?
    public var dishMainDelegate: DishMainViewDelegate?
    
    //PRIVATE
    private var delegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
    private var tap: UITapGestureRecognizer!
    private let imagePicker = UIImagePickerController()
    private weak var tabBarVC: TabBarViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
  
        getTabBarVC()
        subscribes()
        configKeyboard()
        
        if let pc = delegate.window?.rootViewController?.presentedViewController
        {
            print(pc.debugDescription)
        }
        else if let controllers = delegate.window?.rootViewController?.children
        {
            for controller in controllers{
                print(controller.debugDescription)
            }
        }
        
    }
    
    private func subscribes(){
        fillFeedbackViewModel.userInfo.asObservable().subscribe(onNext: { [weak self] (_) in
            self?.setupFieldMenuType()
            self?.setupUserInfoData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //show alert
        if delegate.didShowAlertFeedback == false{
            delegate.didShowAlertFeedback = true
            self.performSegue(withIdentifier: SegueID.alertFeed.id, sender: nil)
        }
    }
    
    //MARK:- Helpers
    private func setupFieldMenuType(){
        let data = self.fillFeedbackViewModel.getItemDataFeedback()
        if let titleName = data.titleName{
            viewMenuType.isHidden = false
         
            titleMenuType.text = titleName
            
            if titleName.uppercased() == FillFeedbackHeader.aboutCafe.titleNameVC?.uppercased(){
                markOnMapMenuTypeBtn.isHidden = true
                if let text = fillFeedbackViewModel.nameSelectCafe(), text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                    descriptionMenuType.text = text
                    (descriptionMenuType as! UITextFieldDesignable).borderC = UIColor(named: "Black282A2F")!
                }else{
                    fillFeedbackViewModel.idSelectCafe = nil
                    descriptionMenuType.text = ""
                    (descriptionMenuType as! UITextFieldDesignable).borderC = UIColor(named: "Brown_B8B1AB_60")!
                }
                
            }else{
                markOnMapMenuTypeBtn.isHidden = true
                if let text = fillFeedbackViewModel.nameSelectDish(), text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                    descriptionMenuType.text = text
                    (descriptionMenuType as! UITextFieldDesignable).borderC = UIColor(named: "Black282A2F")!
                }else{
                    fillFeedbackViewModel.idSelectDish = nil
                    descriptionMenuType.text = ""
                    (descriptionMenuType as! UITextFieldDesignable).borderC = UIColor(named: "Brown_B8B1AB_60")!
                }
            }
        }else{
            viewMenuType.isHidden = true
        }
    }
    
    private func setupUserInfoData(){
        for info in PersonalInfoField.allCases{
            if info.tag < personalInfoTF.count{
                switch info {
                case .name:
                    personalInfoTF[info.tag].text = fillFeedbackViewModel.nameUser()
                case .surname:
                    personalInfoTF[info.tag].text = fillFeedbackViewModel.sernameUser()
                case .phone:
                    personalInfoTF[info.tag].text = fillFeedbackViewModel.phoneUser()
                default:
                    break
                }
            }
        }
        setupTextField()
    }
    
    fileprivate func setupTextField(){
        // выделить заполненные поля
        for tf in personalInfoTF{
            if tf.text == ""{
                tf.isUserInteractionEnabled = true
                tf.borderC = UIColor(named: "Brown_B8B1AB_60")!
            }else{
                if tf.tag == PersonalInfoField.name.tag || tf.tag == PersonalInfoField.surname.tag || tf.tag == PersonalInfoField.phone.tag{
                    //поля инфомации о пользователе если есть уже данные редактировать нельзя
                    tf.isUserInteractionEnabled = false
                }else{
                    tf.isUserInteractionEnabled = true
                }
                tf.borderC = UIColor(named: "Black282A2F")!
            }
        }
        
        if commentTextView.text == ""{
            commentView.borderC = UIColor(named: "Brown_B8B1AB_60")!
        }else{
            commentView.borderC = UIColor(named: "Black282A2F")!
        }
    }
    
    //MARK:- TabBarVC
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
    
    
    //MARK:- Actions
    @IBAction func optionsTypeFeed(_ sender: UIButton){
        let data = self.fillFeedbackViewModel.getItemDataFeedback()
        if let segueID = data.segueID{
            self.performSegue(withIdentifier: segueID, sender: nil)
        }
    }
    
    @IBAction func sendFeedback(){
        let result = fillFeedbackViewModel.chekValidDataFeedback(name: personalInfoTF[PersonalInfoField.name.tag].text, surname: personalInfoTF[PersonalInfoField.surname.tag].text, phone: personalInfoTF[PersonalInfoField.phone.tag].text, text: commentTextView.text, strengths: personalInfoTF[PersonalInfoField.advantages.tag].text, rating: Int(rating.rating))
        if result.2 == true{
            //отправляем запрос
            requestSendMessage()
        }else{
            if let field = result.0{
                personalInfoTF[field.tag].becomeFirstResponder()
            }else{
                if result.3 != nil, result.3 == true{
                    DispatchQueue.main.async {
                        self.commentTextView.becomeFirstResponder()
                    }
                }else{
                    if let message = result.1{
                        alertWarning(title: "Внимание", message: message, isBack: false)
                    }
                }
            }
        }
    }
    //MARK:- Request
    private func requestSendMessage(){
        
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        let imgsData = fillFeedbackViewModel.getImages()
        fillFeedbackViewModel.requestSendFeedback(name: personalInfoTF[PersonalInfoField.name.tag].text!, surname: personalInfoTF[PersonalInfoField.surname.tag].text!, phone: personalInfoTF[PersonalInfoField.phone.tag].text!, text: commentTextView.text!, strengths: personalInfoTF[PersonalInfoField.advantages.tag].text!, rating: Int(rating.rating), weaknesses: personalInfoTF[PersonalInfoField.disadvantages.tag].text!, images: imgsData) { [weak self] (result, message) in
            
            switch result{
            case .complite:
                self?.requestGetChats(message: message)
            case .error:
               
                self?.removeAllOverlays()
                self?.view.isUserInteractionEnabled = true
                
                if self?.fillFeedbackViewModel.getAuth() != nil{
                    //открываем форму регистрации
                    if let aboutCafeDelegate = self?.aboutCafeDelegate{
                        self?.dismiss(animated: false) {
                            aboutCafeDelegate.logoutFromCafe()
                        }
                        return
                    }
                    
                    if let dishMainDelegate = self?.dishMainDelegate{
                        self?.dismiss(animated: false) {
                            dishMainDelegate.logOut()
                        }
                        return
                    }
                   
                    if let nav = self?.navigationController{
                        nav.popViewController(animated: false)
                        self?.otherViewControllerDelegate?.logout()
                        return
                    }
                }
                if let message = message{
                    self?.alertWarning(title: "", message: message, isBack: false)
                }
            }
        }
    }
    
    //MARK:- Get Chats
    func requestGetChats(message: String?){
        InfoUserAPI.requstObjectInfoUser(type: UserChatsModel.self, request: .userChats, delegate: delegate) { [weak self] (value) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            if let chatModel = value{
                if let success = chatModel.success, success{
                    self?.tabBarVC?.chatModel.accept(chatModel.data ?? [])
                }
            }
            
            if let message = message{
                self?.alertWarning(title: "", message: message, isBack: true)
            }
        }
    }
    
    
    private func alertWarning(title: String, message: String, isBack: Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isBack == false{
            let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            alert.addAction(action)
        }else{
            let action = UIAlertAction(title: "ОК", style: .default) { [weak self] (_) in
                if let nav = self?.navigationController{
                    nav.popViewController(animated: true)
                }else{
                    self?.dismiss(animated: true, completion: nil)
                }
            }
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    

    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Alert
        if let identifier = segue.identifier, identifier == SegueID.alertFeed.id{
            if let dvc = segue.destination as? QAlertFeedbackViewController{
                dvc.isCancel = {[weak self] in
                    self?.navigationController?.popViewController(animated: false)
                }
            }
            return
        }
        
        //MARK:- list cafe
        if let identifier = segue.identifier, identifier == SegueID.cafePlaces.id{
            if let dvc = segue.destination as? CafePlacesViewController{
                dvc.cafePlacesViewModel = CafePlacesViewModel(listCafe: self.fillFeedbackViewModel.getListCafe())
                dvc.didSelectCafe = {
                    [fillFeedbackViewModel, setupFieldMenuType] id in
                    fillFeedbackViewModel.idSelectCafe = id
                    setupFieldMenuType()
                }
            }
            return
        }
        
        //MARK:- list Dish
        if let identifier = segue.identifier, identifier == SegueID.dishFeed.id{
            if let dvc = segue.destination as? DishFeedViewController{
                dvc.dishFeedViewModel = DishFeedViewModel(dishesMainInfo: fillFeedbackViewModel.getListDish())
                dvc.didSelectCafe = {
                    [fillFeedbackViewModel, setupFieldMenuType] id in
                    fillFeedbackViewModel.idSelectDish = id
                    setupFieldMenuType()
                }
            }
        }
    }
    
    //MARK:- deinit
    deinit {
        print("FillFeedbackViewController is deinit")
    }
}

//MARK:- Collection View
extension FillFeedbackViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if feedTypeCollectionView == collectionView{
            return fillFeedbackViewModel.numberOfRow(in: section)
        }else{
            return fillFeedbackViewModel.numberOfRowImages()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if feedTypeCollectionView == collectionView{
            let cellData = fillFeedbackViewModel.cellForRow(at: indexPath)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.feedbackType.identifire, for: indexPath) as! FeedbackTypeCollectionViewCell
            cell.dataFeedback = cellData
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.addImages.identifire, for: indexPath) as! AddImageCollectionViewCell
            cell.dataImage = fillFeedbackViewModel.cellForRowImage(at: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if feedTypeCollectionView == collectionView{
            self.fillFeedbackViewModel.didSelect(at: indexPath)
            collectionView.reloadData()
            setupFieldMenuType()
        }else{
            if fillFeedbackViewModel.didSelectImage(at: indexPath) == .add{
                setupPockerVC()
            }else{
                DispatchQueue.main.async {
                    self.alertShow(indexPath: indexPath)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if feedTypeCollectionView == collectionView{
            let width = self.fillFeedbackViewModel.getWightTextAt(indexPath: indexPath)
            return CGSize(width: width, height: 44.0)
        }else{
            return CGSize(width: 48.0, height: 48.0)
        }
    }
}

//MARK:- TF Delegate
extension FillFeedbackViewController: UITextFieldDelegate, UITextViewDelegate{
    fileprivate func configKeyboard(){
        //dissmis keyboard
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        view.addGestureRecognizer(tap)
        registerForKeyboardNotification()
    }
    
    @objc func dismissKeyboard() {
        setupTextField()
        view.endEditing(true)
        tap.isEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField != emptyTF{
            setupTextField()
            (textField as! UITextFieldDesignable).borderC = UIColor(named: "RedA4262A")!
            tap.isEnabled = true
        }else{
            commentTextView.becomeFirstResponder()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setupTextField()
        commentView.borderC = UIColor(named: "RedA4262A")!
        tap.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag + 1 < personalInfoTF.count{
            personalInfoTF[textField.tag + 1].becomeFirstResponder()
        }else{
            emptyTF.becomeFirstResponder()
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            dismissKeyboard()
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true}
        
        if textField.tag == PersonalInfoField.phone.tag{
            textField.text = fillFeedbackViewModel.formattedNumber(number: currentText)
            return false
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

//MARK: - Image PickerView
extension FillFeedbackViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func setupPockerVC(){
        checkPermission()

        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
    }
    
    private func alertShow(indexPath: IndexPath){
        let alert = UIAlertController(title: "Удалить", message: "Вы действительно хотите удалить прикрепленное фото", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { [weak self] (_) in
            self?.fillFeedbackViewModel.removeImage(at: indexPath)
            self?.addImagesCollectionView.reloadData()
        }
    
        let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openPermission(){
        let alert = UIAlertController(title: "Предупреждение", message: "Пользователь отказал в доступе к фото библиотеке, разрешить?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    
        let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        alert.addAction(actionNo)
        alert.addAction(actionYes)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
            self.present(imagePicker, animated: true, completion: nil)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            openPermission()
            
        @unknown default:
            print("unknow ndefault")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            fillFeedbackViewModel.updateGalery(image: pickedImage)
            self.addImagesCollectionView.reloadData()
        }
        dismiss(animated: true) {
        }
    }
}
