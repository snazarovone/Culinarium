//
//  ContactsViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import MessageUI
import RxSwift
import RxCocoa

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var phoneNumberCenter: UILabel!
    @IBOutlet weak var timeWork: UILabel!
    
    //PUBLIC
    public var contactsViewModel: ContactsViewModel!
    
    //PRIVATE
    private weak var contactDelegate: ContactDelegate?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactDelegate = self
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.view.layoutIfNeeded()
        
        subscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .always
        self.view.layoutIfNeeded()
    }
    
    private func subscribes(){
        contactsViewModel.contacts().asObservable().subscribe(onNext: { [weak self] (_) in
            self?.tableView?.reloadData()
            self?.phoneNumberCenter.text = self?.contactsViewModel.contactNumber
            self?.timeWork.text = self?.contactsViewModel.workTime
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK :- Email
    func sendEmail(at email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    
    //MARK:- Actions
    @IBAction func backCall(_ sender: UIButton){
        performSegue(withIdentifier: SegueID.backCall.id, sender: nil)
    }

    //MARK:- deinit
    deinit{
        print("ContactsViewController is deinit")
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = contactsViewModel.cellForRow(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.contacts.identifire) as! ContactTableViewCell
        cell.dataContact = cellData
        cell.contactDelegate = contactDelegate
        return cell
    }
    
}

extension ContactsViewController: ContactDelegate{
    func send(at mail: String) {
        if mail != ""{
            sendEmail(at: mail)
        }
    }
    
    func call(at phone: String) {
        phone.makeACall()
    }
    
}

extension ContactsViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
