//
//  AddressesViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftOverlays

class AddressesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeAddress: UIButtonDesignable!
    @IBOutlet weak var addAddressBtn: UIButtonDesignable!
    @IBOutlet weak var trash: UIBarButtonItem!
    
    private var addressesViewModel: AddressesViewModel!
    private let disposeBag = DisposeBag()
    
    //PUBLIC
    public var myAddresses: BehaviorRelay<[AddressInfoUser]> = BehaviorRelay(value: [])
    public var setLogout: (()->())? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressesViewModel = AddressesViewModel(delegateAddress: self, addresses: myAddresses)
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK:- Helpers
    //внешний вид кнопок добавить и удалить в зависимоти от состояния редактирования
    fileprivate func setupBusttons(){
        if addressesViewModel.isEdit == false{
            addAddressBtn.backgroundColor = UIColor(named: "RedA4262A") ?? .red
            addAddressBtn.setTitleColor(.white, for: .normal)
            
            removeAddress.backgroundColor = UIColor(named: "Gray_D4D0CD") ?? .gray
            removeAddress.setTitleColor(UIColor(named: "Black282A2F") ?? .black, for: .normal)
            removeAddress.setTitle("Удалить адрес", for: .normal)
        }else{
            addAddressBtn.backgroundColor = UIColor(named: "E1DEDB") ?? .red
            addAddressBtn.setTitleColor(UIColor(named: "Gray_282A2F_60") ?? .black, for: .normal)
            
            removeAddress.backgroundColor = UIColor(named: "RedA4262A") ?? .gray
            removeAddress.setTitleColor(.white, for: .normal)
            removeAddress.setTitle("Сохранить изменения", for: .normal)
        }
    }
    
    //MARK:- Subscribes
    private func subscribe(){
        myAddresses.asObservable().subscribe(onNext: { [weak self] (value) in
            self?.tableView.reloadData()
            if value.count > 0{
                self?.trash.isHidden = false
                self?.removeAddress.isHidden = false
            }else{
                self?.trash.isHidden = true
                self?.removeAddress.isHidden = true
            }
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK:- Request Remove Address
    private func requestRemoveAddress(at indexPath: IndexPath){
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        addressesViewModel.requestRemoveAddress(at: indexPath) { [weak self] (result) in
       
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
         
            switch result{
            case .complite:
                break
            case .error:
                if self?.addressesViewModel.getAuth() != nil{
                    //открываем форму регистрации
                    self?.setLogout?()
                }
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func addAddress(_ sender: UIButton){
        self.performSegue(withIdentifier: SegueID.addAddress.id, sender: nil)
    }
    
    @IBAction func editAddresses(_ sender: UIBarButtonItem) {
        addressesViewModel.isEdit = !addressesViewModel.isEdit
        setupBusttons()
        self.tableView.reloadData()
        trash.isHidden = true
    }
    
    //удалить адрес или сохранить изменения
    @IBAction func remove(_ sender: UIButton) {
        addressesViewModel.isEdit = !addressesViewModel.isEdit
        setupBusttons()
        self.tableView.reloadData()
        
        if addressesViewModel.isEdit{
            //сохранить
            trash.isHidden = true
        }else{
            trash.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- Alert Remove Address
        if let identifier = segue.identifier, identifier == SegueID.removeAddress.id{
            if let dvc = segue.destination as? RemoveAddressViewController, let indexPath = sender as? IndexPath{
                dvc.isRemove = {
                    [weak self] in
                    self?.requestRemoveAddress(at: indexPath)
                }
            }
            return
        }
        
        if let identifier = segue.identifier, identifier == SegueID.addAddress.id{
            if let dvc = segue.destination as? AddAddressViewController{
                dvc.myAddresses = myAddresses
                
                dvc.setLogout = {
                    [weak self] in
                    self?.setLogout?()
                }
            }
        }
    }
    
    //MARK:- deinit
    deinit {
        print("AddressesViewController is deinit")
    }
}

//MARK:- TableView Addresses
extension AddressesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressesViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.address.identifire) as! AddressTableViewCell
        let cellData = addressesViewModel.cellForRow(at: indexPath)
        cell.dataAddress = cellData
        return cell
    }
 
}

extension AddressesViewController: AddressActionDelegate{
    func removeAddress(at indexPath: IndexPath){
        performSegue(withIdentifier: SegueID.removeAddress.id, sender: indexPath)
    }
}
