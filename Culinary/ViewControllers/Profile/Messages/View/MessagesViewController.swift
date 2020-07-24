//
//  MessagesViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import Photos
import SwiftOverlays

class MessagesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    
    //Constraint
    @IBOutlet weak var tableBottom: NSLayoutConstraint!
    @IBOutlet weak var messageViewBottom: NSLayoutConstraint!
    @IBOutlet weak var stackAddMessage: UIStackView!
    @IBOutlet var addImageViews: [UIView]! //isHide when empty
    
    @IBOutlet weak var addFile_Btn: UIButton! //isHide when == 3 images
    @IBOutlet weak var send_Btn: UIButton! //disable when filds empty
    
    
    //PUBLIC
    public var messageViewModel: MessagesViewModel!
    
    //PAIVATE
    private var tap : UITapGestureRecognizer!
    private let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configKeyboard()
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 100.0, right: 0.0)
        messageViewModel.requestStatusIsRead()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    private func getTabBarVC(){
        guard let splashVC = UIApplication.shared.windows.first?.rootViewController as? SplashViewController else {return}
       
        for chieldVC in splashVC.children{
            if let tabBarVC = chieldVC as? TabBarViewController{
                tabBarVC.logout()
                return
            }
        }
        if let tabBarVC = splashVC.presentedViewController as? TabBarViewController{
             tabBarVC.removeDataAuth()
             tabBarVC.logout()
        }
    }
    
    //MARK:- Send New Message
    private func sendNewMessage(){
        showWaitOverlay()
        view.isUserInteractionEnabled = false
        
        messageViewModel.requestSendNewMessage(text: messageTF.text) { [weak self] (result, error) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            switch result{
            case .complite:
                self?.messageTF.text = nil
                self?.removeAllAddImages()
                self?.validFields(text: self?.messageTF.text)
                self?.tableView?.reloadData()
            case .error:
                if self?.messageViewModel.getAuth() != nil{
                    //выход
                    self?.getTabBarVC()
                }else{
                    if let error = error{
                        self?.alertWarning(title: "Ошибка", message: error)
                    }else{
                        self?.messageTF?.becomeFirstResponder()
                    }
                }
            }
        }
    }
    
    private func alertWarning(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel) { [messageTF] (_) in
            messageTF?.becomeFirstResponder()
        }
        alert.addAction(action)
           
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Actions
    @IBAction func send(_ sender: UIButton) {
        self.dismissKeyboard()
        sendNewMessage()
    }
    
    @IBAction func addFile(_ sender: UIButton) {
        setupPockerVC()
    }

    @IBAction func removeImage(_ sender: UIButton) {
        let tag = sender.tag
        alertShow(tag: tag)
    }
    //MARK:- deinit
    deinit{
        print("MessagesViewController is deinit")
    }

}

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.message.identifire) as! MessageTableViewCell
        cell.dataMessage = self.messageViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- TextField
extension MessagesViewController: UITextFieldDelegate{
    fileprivate func configKeyboard(){
        //dissmis keyboard
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
    
    private func validFields(text: String?){
        if let text = text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
            send_Btn.alpha = 1
            send_Btn.isUserInteractionEnabled = true
        }else{
            for img in messageViewModel.addImages{
                if img != nil{
                    send_Btn.alpha = 1
                    send_Btn.isUserInteractionEnabled = true
                }else{
                    send_Btn.alpha = 0.3
                    send_Btn.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let row = self.messageViewModel.numberOfRow(in: 0) - 1
        if row >= 0{
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        tap.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        //отправка запроса на сервер
        sendNewMessage()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true}
        validFields(text: currentText)
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
        self.messageViewBottom.constant = keyboardFrame.height - 80
        self.tableBottom.constant = keyboardFrame.height - 80
        
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { [weak self] in
                        if let self = self{
                            self.view.layoutIfNeeded()
                        }
            },
                       completion: { [weak self] (_) in
                        //скролим до самого последнего сообщения
                        if let self = self{
                            let row = self.messageViewModel.numberOfRow(in: 0) - 1
                            if row >= 0{
                                let indexPath = IndexPath(row: row, section: 0)
                                DispatchQueue.main.async {
                                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                }
                            }
                        }
                        
        })
    }

    @objc func kbWillHide(_ notification: Notification){
        let userInfo = notification.userInfo!
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        self.messageViewBottom.constant = .zero
        self.tableBottom.constant = .zero
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

//MARK:- Images Picker
extension MessagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func setupPockerVC(){
        checkPermission()

        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
    }
    
    private func alertShow(tag: Int){
        let alert = UIAlertController(title: "Удалить", message: "Вы действительно хотите удалить прикрепленное фото", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { [weak self] (_) in
            self?.messageViewModel.addImages[tag] = nil
            self?.addImageViews[tag].isHidden = true
            self?.checkAddNewImage()
            self?.validFields(text: self?.messageTF.text)
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
            let tag = addMessageInStack(image: pickedImage)
            messageViewModel.addImages[tag] = pickedImage
            validFields(text: messageTF.text)
            checkAddNewImage()
        }
        dismiss(animated: true) {
        }
    }
    
    private func addMessageInStack(image: UIImage) -> Int{
        var tag = 0
        for view in addImageViews{
            if view.isHidden{
                let subviews = view.subviews
                for v in subviews{
                    if let imgView = v as? UIImageView{
                        imgView.image = image
                        view.isHidden = false
                        tag = view.tag
                        break
                    }
                }
                break
            }
        }
        return tag
    }
    
    private func checkAddNewImage(){
        for view in addImageViews{
            if view.isHidden{
                addFile_Btn.alpha = 1
                addFile_Btn.isUserInteractionEnabled = true
                return
            }
        }
        addFile_Btn.alpha = 0.3
        addFile_Btn.isUserInteractionEnabled = false
    }
    
    private func removeAllAddImages(){
        for view in addImageViews{
            view.isHidden = true
        }
        
        messageViewModel.addImages = [nil, nil, nil]
        checkAddNewImage()
    }
}
