//
//  RestorePasswordViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class RestorePasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextFieldDesignable!
    
    //Constraints
    @IBOutlet weak var bottomButtonConst: NSLayoutConstraint!
    
    //PRIVATE
    fileprivate var tap: UITapGestureRecognizer!
    fileprivate let restorePasswordViewModel = RestorePasswordViewModel()
    
    //PUBLIC
    var isComplite: ((String?)->())!

    
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
    
    //MARK:- Reauest
    fileprivate func request(){
        self.view.isUserInteractionEnabled = false
        self.showWaitOverlay()
        
        restorePasswordViewModel.requestRestoreAccount(email: emailTF.text) { [weak self] (authModel) in
            self?.view.isUserInteractionEnabled = true
            self?.removeAllOverlays()
            
            if let authModel = authModel{
                if let success = authModel.success, success{
                    self?.isComplite(authModel.message)
                }else{
                    self?.isComplite(authModel.error)
                }
            }else{
                self?.isComplite(nil)
            }
            
            self?.dismissKeyboard()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func restorePassword(_ sender: UIButton) {
        request()
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismissKeyboard()
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- deinit
    deinit{
        print("RestorePasswordViewController is deinit")
    }

}

//MARK:- TextFiled Delegate
extension RestorePasswordViewController: UITextFieldDelegate{
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
        selectField(textField: textField as! UITextFieldDesignable)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //отправка запроса на сервер
        self.request()
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
        
        self.bottomButtonConst.constant = 284.0
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
        }
    }
    
    private func endSelectedFields(){
        DispatchQueue.main.async {
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
