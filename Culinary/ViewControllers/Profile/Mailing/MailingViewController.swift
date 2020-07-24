//
//  MailingViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftOverlays

class MailingViewController: UIViewController {
    
    @IBOutlet weak var checkBtn: UIButtonDesignable!
    
    public var newsLetter: BehaviorRelay<NewsLetter> = BehaviorRelay(value: .notSubscribe)
    public var setLogout: (()->())? = nil
    
    private let disposeBag = DisposeBag()
    private let delegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK:- Subscribes
    private func subscribes(){
        newsLetter.asObservable().subscribe(onNext: { [weak self] (newsLetter) in
            self?.changeCheck()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK:- Helpers
    private func changeCheck(){
        if newsLetter.value == .subscribe{
            checkBtn.setImage(#imageLiteral(resourceName: "Check"), for: .normal)
        }else{
            checkBtn.setImage(nil, for: .normal)
        }
    }
    
    private func requestChangeNewsLetter(){
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        InfoUserAPI.requstObjectInfoUser(type: NewsLetterModel.self, request: .setNewsletter(status: newsLetter.value), delegate: delegate) { [weak self] (value) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            if let news = value{
                if let success = news.success, success{
                    self?.newsLetter.accept(news.status)
                    return
                }else{
                    if let error = news.error, error == ErrorAuth.Unauthorized.value{
                        //выход из аккаунта
                        self?.setLogout?()
                    }
                    self?.changeStatus()
                }
            }else{
                self?.changeStatus()
            }
        }
    }
    
    private func changeStatus(){
        if newsLetter.value == .subscribe{
            newsLetter.accept(.notSubscribe)
        }else{
            newsLetter.accept(.subscribe)
        }
    }
    
    //MARK:- Actions
    @IBAction func check(_ sender: UIButtonDesignable){
        changeStatus()
        requestChangeNewsLetter()
    }

    //MARK:- deinit
    deinit{
        print("MailingViewController is deinit")
    }

}
