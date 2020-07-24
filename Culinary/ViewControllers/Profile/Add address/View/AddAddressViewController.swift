//
//  AddAddressViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftOverlays

class AddAddressViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var addressTF: [UITextFieldDesignable]!
    @IBOutlet weak var addAddressBtn: UIButton!
    
    //PRIVATE
    private var tap: UITapGestureRecognizer!
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //PUBLIC
    public var myAddresses: BehaviorRelay<[AddressInfoUser]> = BehaviorRelay(value: [])
    public var setLogout: (()->())? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        configKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupTF(){
        for address in AddressTF.allCases{
            addressTF[address.tag].attributedPlaceholder = address.hint
        }
    }
    
    fileprivate func selectTextField(){
        // выделить заполненные поля
        for tf in addressTF{
            if tf.text == ""{
                tf.borderC = UIColor(named: "Brown_B8B1AB_60")!
            }else{
                tf.borderC = UIColor(named: "Black282A2F")!
            }
        }
    }
    
    fileprivate func checkValidFields(addressCurrent: AddressTF) -> Bool{
        let isEnable = true
        for address in AddressTF.allCases{
            switch address{
            case .name, .city, .street:
                if (addressTF[address.tag].text?.count ?? 0) <= 0{
                    if addressCurrent == address{
                        break
                    }
                    return false
                }
            default:
                break;
            }
        }
        return isEnable
    }
    
    fileprivate func checkValidField(currentText: String, address: AddressTF){
        if currentText.count > 0{
            //проверяем остальные поля
            if checkValidFields(addressCurrent: address){
                enableBtnAddAddress()
            }else{
                disableBtnAddAddress()
            }
        }else{
            disableBtnAddAddress()
        }
    }
    
    fileprivate func disableBtnAddAddress(){
        addAddressBtn.isEnabled = false
        addAddressBtn.setTitleColor(UIColor(named: "Gray_282A2F_60") ?? .gray, for: .normal)
    }
    
    fileprivate func enableBtnAddAddress(){
        addAddressBtn.isEnabled = true
        addAddressBtn.setTitleColor(UIColor(named: "Black282A2F") ?? .black, for: .normal)
    }
    
    
    //MARK:- Request AddAddress
    private func requestAddAddress(){
        var title = "", city = "", street = ""
        var house: String?, porch: String?, flat: String?, door_code: String?, floor: Int?
        for address in AddressTF.allCases{
            switch address {
            case .name:
                title = addressTF[address.tag].text ?? ""
            case .city:
                city = addressTF[address.tag].text ?? ""
            case .street:
                street = addressTF[address.tag].text ?? ""
            case .numberHouse:
                house = addressTF[address.tag].text
            case .numberFront:
                porch = addressTF[address.tag].text
            case .numberFlat:
                flat = addressTF[address.tag].text
            case .numberFloor:
                if let text = addressTF[address.tag].text, let floorValue = Int(text){
                    floor = floorValue
                }
            case .numberCode:
                door_code = addressTF[address.tag].text
            }
        }
        
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        InfoUserAPI.requstObjectInfoUser(type: AddressInfoUserModel.self, request: .addAddress(title: title, city: city, street: street, house: house, porch: porch, flat: flat, door_code: door_code, floor: floor), delegate: delegate) { [weak self] (value) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            if let addresses = value{
                if let success = addresses.success, success{
                    self?.myAddresses.accept(addresses.data ?? [])
                    self?.navigationController?.popViewController(animated: true)
                }else{
                    if let error = addresses.error, error == ErrorAuth.Unauthorized.value{
                        //выход из аккаунта
                        self?.setLogout?()
                    }
                    self?.alertShow(message: addresses.error ?? "Повторите попытку")
                }
            }else{
                self?.alertShow(message: "Повторите попытку")
            }
        }
    }
    
    private func alertShow(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addAddressAction(_ sender: UIButtonDesignable) {
        requestAddAddress()
    }
    
    @IBAction func setOnMapAddress(_ sender: UIButtonDesignable) {
    }
    
    
    //MARK:- deinit
    deinit{
        print("AddAddressViewController is deinit")
    }
}

//MARK:- TextFields
extension AddAddressViewController: UITextFieldDelegate{
    fileprivate func configKeyboard(){
         //dissmis keyboard
         tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
         tap.isEnabled = false
         //event свернуть клавиатуру если был тап в пустую область
         view.addGestureRecognizer(tap)
         registerForKeyboardNotification()
     }
     
     @objc func dismissKeyboard() {
         selectTextField()
         view.endEditing(true)
         tap.isEnabled = false
     }
     
     func textFieldDidBeginEditing(_ textField: UITextField) {
         selectTextField()
         (textField as! UITextFieldDesignable).borderC = UIColor(named: "RedA4262A")!
         tap.isEnabled = true
     }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         if textField.tag + 1 < addressTF.count{
             addressTF[textField.tag + 1].becomeFirstResponder()
         }else{
             dismissKeyboard()
         }
         return true
     }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true}
        
        var addressTF: AddressTF = .name
        for address in AddressTF.allCases{
            if address.tag == textField.tag{
                addressTF = address
                break
            }
        }
        
        checkValidField(currentText: currentText, address: addressTF)
        
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
