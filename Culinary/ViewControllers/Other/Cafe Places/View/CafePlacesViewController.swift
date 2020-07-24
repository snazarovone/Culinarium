//
//  CafePlacesViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CafePlacesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    public var cafePlacesViewModel = CafePlacesViewModel(listCafe: BehaviorRelay(value: nil))
    
    public var didSelectCafe: ((Int?)->())?
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.navigationController == nil{
            navBar.isHidden = false
        }else{
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        subscribes()
    }
    
    private func subscribes(){
        cafePlacesViewModel.getListCafe().asObservable().subscribe(onNext: { [tableView] (_) in
            tableView?.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- deinit
    deinit {
        print("CafePlacesViewController is deinint")
    }

}

extension CafePlacesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafePlacesViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.cafePlaces.identifire) as! CafePlaceTableViewCell
        cell.dataCafe = cafePlacesViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCafe?(cafePlacesViewModel.didSelectRow(at: indexPath))
        if let navigationController = self.navigationController{
            navigationController.popViewController(animated: true)
        }else{
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
