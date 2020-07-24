//
//  PersonalInformationViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PersonalInformationViewController: UIViewController {
    
    @IBOutlet var personalInfoTF : [UITextFieldDesignable]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var externalCircles: [UIViewDesignable]!
    @IBOutlet var internalCircles: [UIViewDesignable]! //isHidden
    @IBOutlet weak var saveData: UIButtonDesignable!
    
    //PRIVATE
    private var tap: UITapGestureRecognizer!
    
    //PUBLIC
    public var personalInfoViewModel: PersonalInfoViewModel!
    public var setLogout: (()->())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillFieldsData()
        changeGender() //устанавливаем radio button

        configKeyboard()
        
        // выделить заполненные поля
        setupTextField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func fillFieldsData(){
        for info in InfoTF.allCases{
            if info.tag < personalInfoTF.count{
                switch info {
                case .name:
                    personalInfoTF[info.tag].text = personalInfoViewModel.userInfoData.value?.name
                case .surname:
                    personalInfoTF[info.tag].text = personalInfoViewModel.userInfoData.value?.surname
                case .secondName:
                    personalInfoTF[info.tag].text = personalInfoViewModel.userInfoData.value?.patronymic
                case .email:
                    personalInfoTF[info.tag].text = personalInfoViewModel.userInfoData.value?.email
                case .phone:
                    personalInfoTF[info.tag].text = personalInfoViewModel.userInfoData.value?.phone
                case .birthday:
                    personalInfoTF[info.tag].text = personalInfoViewModel.userInfoData.value?.birth_date
                }
            }
        }
    }
    
    fileprivate func setupTextField(){
        // выделить заполненные поля
        for tf in personalInfoTF{
            if tf.text == ""{
                tf.borderC = UIColor(named: "Brown_B8B1AB_60")!
            }else{
                tf.borderC = UIColor(named: "Black282A2F")!
            }
        }
    }
    
    fileprivate func changeGender(){
        if personalInfoViewModel.gender == .man{
            externalCircles[GenderModel.women.tag].borderC = UIColor(named: "BrownB8B1AB") ?? .black
            externalCircles[GenderModel.man.tag].borderC = UIColor(named: "RedA4262A") ?? .red
            internalCircles[GenderModel.women.tag].isHidden = true
            internalCircles[GenderModel.man.tag].isHidden = false
        }else{
            externalCircles[GenderModel.women.tag].borderC = UIColor(named: "RedA4262A") ?? .black
            externalCircles[GenderModel.man.tag].borderC = UIColor(named: "BrownB8B1AB") ?? .red
            internalCircles[GenderModel.women.tag].isHidden = false
            internalCircles[GenderModel.man.tag].isHidden = true
        }
    }
    
    //MARK:- Actions
    @IBAction func woman(_ sender: UIButton) {
        personalInfoViewModel.gender = .women
        changeGender()
    }
    
    @IBAction func man(_ sender: UIButton) {
        personalInfoViewModel.gender = .man
        changeGender()
    }
    
    //MARK:- Change InfoUser
    @IBAction func changeData(_ sender: UIButton) {
        var name, surname, patronymic, birth_date, phone : String?
        
        for info in InfoTF.allCases{
            if info.tag < personalInfoTF.count{
                switch info {
                case .name:
                    name = personalInfoTF[info.tag].text
                case .surname:
                    surname = personalInfoTF[info.tag].text
                case .secondName:
                    patronymic = personalInfoTF[info.tag].text
                case .email:
                    break
                case .phone:
                    if personalInfoTF[info.tag].text?.count == 17{
                        phone = personalInfoTF[info.tag].text
                    }
                case .birthday:
                    if personalInfoTF[info.tag].text?.count == 10{
                        birth_date = personalInfoTF[info.tag].text
                    }
                }
            }
        }
        
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        personalInfoViewModel.requestChangeUserInfo(name: name, surname: surname, patronymic: patronymic, birth_date: birth_date, phone: phone) { [weak self] (result) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            switch result{
            case .complite:
                self?.fillFieldsData()
                break
            case .error:
                if self?.personalInfoViewModel.getAuth() != nil{
                    //открываем форму регистрации
                    self?.setLogout?()
                }
            }
        }
    }
    

    //MARK:- deinit
    deinit{
        print("PersonalInformationViewController is deinit")
    }
}

extension PersonalInformationViewController: UITextFieldDelegate{
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
        startPhone(textField: textField)
        print(textField.tag)
    }
    
    private func startPhone(textField: UITextField){
        if  textField == personalInfoTF[InfoTF.phone.tag] && textField.text == ""{
            textField.text = personalInfoViewModel.formattedNumber(number: "7")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag + 1 < personalInfoTF.count{
            if textField.tag + 1 == InfoTF.email.tag{
                //поле email нельзя редактировать
                personalInfoTF[textField.tag + 2].becomeFirstResponder()
            }else{
                personalInfoTF[textField.tag + 1].becomeFirstResponder()
            }
        }else{
            dismissKeyboard()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true}
        
        if textField.tag == InfoTF.phone.tag{
            textField.text = personalInfoViewModel.formattedNumber(number: currentText)
            startPhone(textField: textField)
            return false
        }
        
        if textField.tag == InfoTF.birthday.tag{
            textField.text = personalInfoViewModel.formattedData(number: currentText)
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
