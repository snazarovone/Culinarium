//
//  BackCallViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import SwiftOverlays

class BackCallViewController: UIViewController {
    
    
    @IBOutlet weak var viewOnEffectV: UIView!
    @IBOutlet weak var viewVisualEffect: UIVisualEffectView!
    @IBOutlet weak var centerView: NSLayoutConstraint!
    @IBOutlet weak var topView: NSLayoutConstraint!
    @IBOutlet weak var nameTF: UITextFieldDesignable!
    @IBOutlet weak var phoneTF: UITextFieldDesignable!
    @IBOutlet weak var timeTF: UITextFieldDesignable! //is not edit user
    @IBOutlet weak var timeSelectBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButtonDesignable!
    @IBOutlet weak var commentTV: KMPlaceholderTextView!
    @IBOutlet weak var pickerView: UIView! //hide is default
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var underPicker: UIView! //default alpha == 0
    
    
    private var centerViewDefault: CGFloat = 0.0
    private var tap: UITapGestureRecognizer!
    private var tapToUnder: UITapGestureRecognizer!
    
    private var backCallViewModel: BackCallViewModel!
    private var isShowPicker = false
    private var tabBarVC: TabBarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getTabBarVC()
        backCallViewModel = BackCallViewModel(userInfo: tabBarVC.userInfo)
        
        phoneTF.text = backCallViewModel.phoneUser
        nameTF.text = backCallViewModel.name
        
        centerViewDefault = centerView.constant
        
        self.viewVisualEffect.alpha = 0.0
        self.viewVisualEffect.effect = nil
        
        bottomConstraint.constant = CGFloat(-256.0)
        
        configKeyboard()
        
        tapToUnder = UITapGestureRecognizer(target: self, action: #selector(self.underTap))
        tapToUnder.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        underPicker.addGestureRecognizer(tapToUnder)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.8) {
            self.viewVisualEffect.effect = UIBlurEffect(style: .regular)
            self.viewVisualEffect.alpha = 1.0
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
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeNotificationKeyBoard()
    }
    
    
    
    //MARK:- Requst CallBack
    private func requestCallBack(){
        guard validationFields() else {
            return
        }
        
        showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        backCallViewModel.requestListMeneSection(name: nameTF.text!, time: timeTF.text!, phone: phoneTF.text!, text: commentTV.text ?? "") { [weak self] (result) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            switch result{
            case .complite:
                self?.alertWarning(title: "", message: "Обратный звонок зарегистрирован!", isBack: true)
            case .error:
                if self?.backCallViewModel.getAuth() != nil{
                    self?.dismiss(animated: false, completion: {
                        self?.tabBarVC.removeDataAuth()
                        self?.tabBarVC.logout()
                    })
                    return
                }
                self?.alertWarning(title: "Ошибка", message: "Произошла непредвиденная ошибка. повторите попытку позже", isBack: false)
            }
        }
    }
    
    private func validationFields() -> Bool{
        if let text = nameTF.text, text.count > 0{
            if let phone = phoneTF.text, phone.count == 17{
                if let time = timeTF.text, time.count > 0{
                    return true
                }else{
                    showSelectTimeView()
                    return false
                }
            }else{
                phoneTF.becomeFirstResponder()
                return false
            }
        }else{
            nameTF.becomeFirstResponder()
            return false
        }
    }
    
    private func alertWarning(title: String, message: String, isBack: Bool){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isBack == false{
            let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            alert.addAction(action)
        }else{
            let action = UIAlertAction(title: "ОК", style: .default) { [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Actions
    @IBAction func close(_ sender: UIButton){
        dismiss(animated: false) {
        }
    }
    
    @IBAction func send(_ sender: UIButton) {
        dismissKeyboard()
        requestCallBack()
    }
    
    @IBAction func selectTime(_ sender: UIButton) {
        showSelectTimeView()
    }
    
    private func showSelectTimeView(){
        isShowPicker = true
        dismissKeyboard()
        
        bottomConstraint.constant = CGFloat(0.0)
        topView.constant = 64.0 + (centerViewDefault - 128.0)
        centerView.constant = centerViewDefault - 128.0
        underPicker.alpha = 0.0
        tapToUnder.isEnabled = true
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.pickerView.isHidden = false
            self.underPicker.alpha = 1.0
        }
        
        if let text = timeTF.text, text.count > 0{
            return
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            timeTF.text = dateFormatter.string(from: datePicker.date)
        }
    }
    
    
    @IBAction func readyDate(_ sender: UIButton) {
        hidePicker()
    }
    
    @objc func underTap(){
        hidePicker()
    }
    
    private func hidePicker(){
        isShowPicker = false
        
        bottomConstraint.constant = -256.0
        topView.constant = 64.0
        centerView.constant = centerViewDefault
        underPicker.alpha = 1.0
        tapToUnder.isEnabled = false
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.pickerView.isHidden = false
            self.underPicker.alpha = 0.0
        }
    }
    @IBAction func datePic(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        timeTF.text = dateFormatter.string(from: sender.date)
    }
    
    
    //MARK:- deinit
    deinit{
        print("BackCallViewController is deinit")
    }
}


extension BackCallViewController: UITextFieldDelegate, UITextViewDelegate{
    fileprivate func configKeyboard(){
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        view.addGestureRecognizer(tap)
        registerForKeyboardNotification()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        tap.isEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tap.isEnabled = true
        startPhone(textField: textField)
    }
    
    private func startPhone(textField: UITextField){
        if  textField == phoneTF && textField.text == ""{
            textField.text = backCallViewModel.formattedNumber(number: "7")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tap.isEnabled = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTF{
            guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true}
            
            textField.text = backCallViewModel.formattedNumber(number: currentText)
            startPhone(textField: textField)
            return false
            
        }else{
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF{
            phoneTF.becomeFirstResponder()
        }else{
            dismissKeyboard()
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
        
        topView.constant = 64.0 + (centerViewDefault - (keyboardFrame.height / 2.0))
        centerView.constant = centerViewDefault - (keyboardFrame.height / 2.0)

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
        
        topView.constant = 64.0
        centerView.constant = centerViewDefault
        
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
