//
//  ChangePasswordViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SwiftOverlays

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet var passwordsTF: [UITextFieldDesignable]!
    @IBOutlet weak var saveBtn: UIButtonDesignable! //isEnable = false is default
    @IBOutlet weak var scrollView: UIScrollView!
    
    //PRIVATE
    private var tap: UITapGestureRecognizer!
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    
    public var setLogout: (()->())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configKeyboard()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    fileprivate func setupTextField(){
        // выделить заполненные поля
        saveBtn.isEnabled = true
        saveBtn.alpha = 1.0
        for tf in passwordsTF{
            if tf.text == ""{
                tf.borderC = UIColor(named: "Brown_B8B1AB_60")!
                saveBtn.isEnabled = false
                saveBtn.alpha = 0.6
            }else{
                tf.borderC = UIColor(named: "Black282A2F")!
            }
        }
    }
    
    //MARK:- Request Change Password
    private func requestChangePassword(){
        var currentPass = "", newPass = "", confPass = ""
        
        for passT in PasswordTF.allCases{
            if passT.tag < passwordsTF.count{
                switch passT {
                case .current:
                    currentPass = passwordsTF[passT.tag].text ?? ""
                    if currentPass.count == 0{
                        passwordsTF[passT.tag].becomeFirstResponder()
                        setupTextField()
                        return
                    }
                case .new:
                    newPass = passwordsTF[passT.tag].text ?? ""
                    if newPass.count == 0{
                        passwordsTF[passT.tag].becomeFirstResponder()
                        setupTextField()
                        return
                    }
                case .confirm:
                    confPass = passwordsTF[passT.tag].text ?? ""
                    if confPass.count == 0{
                        passwordsTF[passT.tag].becomeFirstResponder()
                        setupTextField()
                        return
                    }
                }
            }
        }
        
        if newPass != confPass{
            self.alertShow(title: "Ошибка", message: "Пароли не совпадают")
            return
        }
        
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
              
        
        InfoUserAPI.requstObjectInfoUser(type: NewPassordModel.self, request: .newPassword(current_password: currentPass, new_password: newPass, new_password_confirm: confPass), delegate: delegate) { [weak self] (value) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            if let value = value{
                if let success = value.success, success{
                    self?.changeUserAuth(newPass: newPass)
                    self?.alertShow(title: "", message: value.message ?? "Пароль был изменен")
               
                    //отчищаем поля
                    for passT in self?.passwordsTF ?? []{
                        passT.text = ""
                    }
                    self?.setupTextField()
                }else{
                    if let error = value.error, error == ErrorAuth.Unauthorized.value{
                        //выход из аккаунта
                        self?.setLogout?()
                    }
                    self?.alertShow(title: "Ошибка", message: value.error ?? "Повторите попытку")
                }
            }else{
                self?.alertShow(title: "Ошибка", message: "Повторите попытку")
            }
        }
    }
    
    private func changeUserAuth(newPass: String){
        let login = UserAuth.shared.login
        let token = UserAuth.shared.token
        
        UserAuth.shared = UserAuth(login: login, pass: newPass, token: token, socialName: nil, socialId: nil)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: UserAuth.shared)
        UserDefaults.standard.set(encodedData, forKey: UDID.dataLogin.key)
    }
    
    private func alertShow(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Actions
    @IBAction func saveChanges(_ sender: UIButton){
        requestChangePassword()
    }
    
    
    //MARK:- deinit
    deinit{
        print("ChangePasswordViewController is deinit")
    }
}

//MARK:- TextField
extension ChangePasswordViewController: UITextFieldDelegate{
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
        setupTextField()
        (textField as! UITextFieldDesignable).borderC = UIColor(named: "RedA4262A")!
        tap.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag + 1 < passwordsTF.count{
            passwordsTF[textField.tag + 1].becomeFirstResponder()
        }else{
            dismissKeyboard()
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
