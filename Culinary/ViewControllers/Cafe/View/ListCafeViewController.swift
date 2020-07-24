//
//  ListCafeViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ListCafeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var onMapBtn: UIButtonDesignable!
    @IBOutlet weak var listBtn: UIButtonDesignable!
    @IBOutlet weak var bottomConstraintTitle: NSLayoutConstraint!
    @IBOutlet weak var topTableView: NSLayoutConstraint!
    @IBOutlet weak var separatorNav: UIView!
    @IBOutlet weak var titleView: UILabel!
    
    var hideListCafe: (()->())? = nil
    var showFilter: (()->())? = nil
    
    private let disposeBag = DisposeBag()
    
    public var listCafeViewModel = ListCafeViewModel()
    public var userInfo: BehaviorRelay<UserInfo?> = BehaviorRelay(value: UserInfo())
    public var dishesMainInfo: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
    public var listCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    
    weak var cafeVCDelegate: CafeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        subscribes()
    }
    
    
    private func subscribes(){
        listCafeViewModel.getFilterListCafe().asObservable().subscribe(onNext: { [weak self] (_) in
            self?.tableView?.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        listCafe.asObservable().subscribe(onNext: { [weak self] (value) in
            for cafeList in value?.cafes ?? []{
                for fCafe in self?.listCafeViewModel.getFilterListCafe().value?.cafes ?? []{
                    if let idCafe = cafeList.id, let idFCafe = fCafe.id, idCafe == idFCafe{
                        fCafe.distance = cafeList.distance
                    }
                }
            }
            self?.tableView.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.aboutCafe.id{
            if let dvc = segue.destination as? AboutCafeViewController{
                dvc.cafe = sender as? Cafe
                dvc.cafeVCDelegate = cafeVCDelegate
            }
            return
        }
    }
    
    
    //MARK:- deinit
    deinit{
        print("ListCafeViewController is deinit")
    }
    
    
    
    //MARK:- Actions
    @IBAction func onMapSW(_ sender: UIButtonDesignable) {
        hideListCafe?()
    }
    
    @IBAction func onList(_ sender: UIButtonDesignable) {
    }
    @IBAction func filters(_ sender: UIButton) {
        showFilter?()
    }
    
}

extension ListCafeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCafeViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.listCafe.identifire) as! ListCafeTableViewCell
        cell.dataCafe = listCafeViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cafe = listCafeViewModel.didSelectCafe(at: indexPath)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: SegueID.aboutCafe.id, sender: cafe)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let ySk = 76.0 + scrollView.contentOffset.y
        let raz = ySk - 76.0
        
        var razT: CGFloat = 24.0
        if raz < 24{
            razT = raz
        }
        
        let textSize = 22.0 - (razT/4)
        
        if ySk >= 100{
            bottomConstraintTitle.constant = 100.0
            topTableView.constant = -62.0 - 24.0
            separatorNav.alpha = 1.0
        }else{
            if ySk <= 76.0{
                bottomConstraintTitle.constant = 76.0
                topTableView.constant = -62.0
                separatorNav.alpha = 0.0
            }else{
                bottomConstraintTitle.constant = ySk
                topTableView.constant = -62.0 - raz
                separatorNav.alpha = razT / 24.0
            }
        }
        if textSize > 19.0{
            if textSize < 29{
                titleView.font = UIFont(name:"Rubik-Bold", size:textSize)!
            }else{
                titleView.font = UIFont(name:"Rubik-Bold", size:29.0)!
            }
        }else{
            titleView.font = UIFont(name:"Rubik-Medium", size:textSize)!
        }
    }
}
