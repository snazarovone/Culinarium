//
//  LoginAppViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SwiftOverlays
import FBSDKCoreKit
import FBSDKLoginKit

class LoginAppViewController: UIViewController {
    
    @IBOutlet weak var warningLB: UILabel!
    @IBOutlet weak var emailTF: UITextFieldDesignable!
    @IBOutlet weak var passwordTF: UITextFieldDesignable!
    @IBOutlet weak var logintBtn: UIButtonDesignable!
    
    //Constraints
    @IBOutlet weak var bottomButtonConst: NSLayoutConstraint!
    
    //PRIVATE
    fileprivate var tap: UITapGestureRecognizer!
    fileprivate let loginAppViewModel = LoginAppViewModel()
    private var authService: AuthService!
    private var vkUserData: VKModel?
    
    //PUBLIC
    var isComplite: (()->())!

    override func viewDidLoad() {
        authService = (UIApplication.shared.delegate as! AppDelegate).authService
        authService.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        configKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeNotificationKeyBoard()
    }
    
    //MARK:- Requests
    private func request(){
        
        self.view.isUserInteractionEnabled = false
        self.showWaitOverlay()
        
        loginAppViewModel.requestIsExistUser(email: emailTF.text, password: passwordTF.text, sns: .notSns, provider_id: nil, provider_name: nil) { [weak self] (authModel) in

            self?.view.isUserInteractionEnabled = true
            self?.removeAllOverlays()
            
            if let authModel = authModel, let success = authModel.success{
                if success == true, let token = authModel.tokenAccess{
                    //сохраняем данные авторизации
                    self?.loginAppViewModel.saveDataAuth(with: token,
                                                         login: self?.emailTF.text,
                                                         pass: self?.passwordTF.text,
                                                         idUser: nil,
                                                         socialName: nil)
                    //переходим на главный экран
                    self?.dismiss(animated: true) {
                        self?.isComplite()
                    }
                }else{
                    //удаляем данные об авторизации
                    self?.loginAppViewModel.removeDataAuth()
                    
                    if let message = authModel.message{
                        //выводим предупреждение
                        self?.warningLB.text = message
                        self?.warningLB.isHidden = false
                    }else{
                        self?.warningLB.text = authModel.error
                        self?.warningLB.isHidden = false
                    }
                }
            }else{
                //выводим предупреждение
                self?.warningLB.text = self?.loginAppViewModel.warningEmailOrPassValidation
                self?.warningLB.isHidden = false
            }
        }
    }
    
    //MARK- Requests
    private func request(email: String, provider_id: String, provider_name: String){
        self.view.isUserInteractionEnabled = false
        self.showWaitOverlay()
        
        let password = loginAppViewModel.generatedPass(at: email)
        
        loginAppViewModel.requestIsExistUser(email: email, password: password, sns: .authSns, provider_id: provider_id, provider_name: provider_name) {  [weak self] (authModel) in
            
            self?.view.isUserInteractionEnabled = true
            self?.removeAllOverlays()
            
            
            if let authModel = authModel, let success = authModel.success{
                if success == true, let token = authModel.tokenAccess{
                    //сохраняем данные авторизации
                    self?.loginAppViewModel.saveDataAuth(with: token,
                                                         login: email,
                                                         pass: password,
                                                         idUser: provider_id,
                                                         socialName: provider_name)
                    //переходим на главный экран
                    self?.dismiss(animated: true) {
                        self?.isComplite()
                    }
                }
                else{
                    //удаляем данные об авторизации
                    self?.loginAppViewModel.removeDataAuth()
                    self?.authService.logout()
                    
                    if let message = authModel.message{
                        //выводим предупреждение
                        self?.warningLB.text = message
                        self?.warningLB.isHidden = false
                    }else{
                        self?.warningLB.text = authModel.error
                        self?.warningLB.isHidden = false
                    }
                }
            }
            else{
                self?.authService.logout()
                //выводим предупреждение
                self?.warningLB.text = self?.loginAppViewModel.warningEmailOrPassValidation
                self?.warningLB.isHidden = false
            }
        }
    }
    
    
    //MARK:- RestorePassword
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.restorePassword.id{
            if let dvc = segue.destination as? RestorePasswordViewController{
                dvc.isComplite = {
                    [weak self] isSend in
                    
                    self?.warningLB.text = isSend
                    self?.warningLB.isHidden = false
                }
            }
            return
        }
    }
    
    //MARK:- Alert
    private func alertShow(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Actions
    @IBAction func restorePassword(_ sender: UIButton){
        emailTF.text = ""
        passwordTF.text = ""
        dismissKeyboard()
        performSegue(withIdentifier: SegueID.restorePassword.id, sender: nil)
    }
    
    @IBAction func hiddenPassword(_ sender: UIButton){
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func login(_ sender: UIButton){
        dismissKeyboard()
        request()
    }
    
    //MARK:- VK
    @IBAction func vk(_ sender: UIButton){
        authService.wakeUpSession()
    }
    
    @IBAction func fb(_ sender: UIButton){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { [weak self] (result, error) in
            print(result?.token?.userID)
        }
    }
    
    @IBAction func gplus(_ sender: UIButton){
        
    }

    //MARK:- deinit
    deinit{
        print("LoginAppViewController is deinit")
    }
}

//MARK:- TextFiled Delegate
extension LoginAppViewController: UITextFieldDelegate{
    fileprivate func configKeyboard(){
        //dissmis keyboard
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        view.addGestureRecognizer(tap)
        registerForKeyboardNotification()
    }
    
    @objc func dismissKeyboard() {
        endSelectedFields()
        view.endEditing(true)
        tap.isEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tap.isEnabled = true
        warningLB.isHidden = true
        selectField(textField: textField as! UITextFieldDesignable)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF{
            passwordTF.becomeFirstResponder()
        }else{
            dismissKeyboard()
            //отправка запроса на сервер
            self.request()
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
        self.bottomButtonConst.constant = keyboardFrame.height
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
        
        self.bottomButtonConst.constant = 180.0
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
    
    //MARK:-Helpers
    private func selectField(textField: UITextFieldDesignable){
        DispatchQueue.main.async {
            textField.borderC = UIColor(named: "TintLogin") ?? .red
            
            if textField == self.emailTF{
                 if self.passwordTF.text?.count ?? 0 > 0{
                     //выделяем белым цветом НЕ выбыранное поле
                     self.passwordTF.borderC = UIColor.white
                 }else{
                     //выделяем полупрозрачным цветом НЕ выбыранное поле
                     self.passwordTF.borderC = UIColor(named: "BorderClear30") ?? .black
                 }
             }else{
                 if self.emailTF.text?.count ?? 0 > 0{
                     //выделяем белым цветом НЕ выбыранное поле
                     self.emailTF.borderC = UIColor.white
                 }else{
                     //выделяем полупрозрачным цветом НЕ выбыранное поле
                    self.emailTF.borderC = UIColor(named: "BorderClear30") ?? .black
                 }
             }
        }
    }
    
    private func endSelectedFields(){
        DispatchQueue.main.async {
            if self.passwordTF.text?.count ?? 0 > 0{
                //выделяем белым цветом НЕ выбыранное поле
                self.passwordTF.borderC = UIColor.white
            }else{
                //выделяем полупрозрачным цветом НЕ выбыранное поле
                self.passwordTF.borderC = UIColor(named: "BorderClear30") ?? .black
            }
            if self.emailTF.text?.count ?? 0 > 0{
                //выделяем белым цветом НЕ выбыранное поле
                self.emailTF.borderC = UIColor.white
            }else{
                //выделяем полупрозрачным цветом НЕ выбыранное поле
                self.emailTF.borderC = UIColor(named: "BorderClear30") ?? .black
            }
        }
    }
}

extension LoginAppViewController: AuthServiceDelegate{
    func authServiceSignIn(email: String?, id: String?) {
        print(#function)
        if let email = email, let id = id{
            self.vkUserData = VKModel(email: email, id: id)
        }else{
            if let id = id{
                self.vkUserData = VKModel(email: nil, id: id)
            }else{
                self.vkUserData = nil
            }
        }
    }
    
    func authServiceShouldShow(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
        print(#function)
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }
    
    
    func vkSdkDidDismiss() {
        
        if let vkModel = self.vkUserData{
            if let email = vkModel.email{
                 request(email: email, provider_id: vkModel.idUser, provider_name: Socials.vk.title)
            }else{
                self.authService.logout()
                self.alertShow(message:
                    self.loginAppViewModel.warningNotExistEmail)
            }
        }else{
                self.authService.logout()
        }
    }
}
