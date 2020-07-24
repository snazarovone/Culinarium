//
//  AboutStockViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class AboutStockViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var code: UITextView!
    
    //PUBLIC
    public var stockCellViewModel: StockCellViewModel?
    
    //PRIVATE
    private weak var timer: Timer?
    private weak var tabBarVC: TabBarViewController!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage(by: URL(string: stockCellViewModel?.image ?? ""))
        getTabBarVC()
        code.text = stockCellViewModel?.coupon_code
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        subscribes()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
        
        if let timer = timer, timer.isValid == false{
            startTimer()
        }else{
            if timer == nil{
                startTimer()
            }
        }
    }
    
    private func subscribes(){
        tabBarVC.stocks.asObservable().skip(1).subscribe(onNext: { [weak self] (value) in
            if value?.actions?.count ?? 0 == 0{
                self?.showAlert(isAll: true)
            }else{
                self?.showAlert(isAll: false)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
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
        endTimer()
    }
    
    private func showAlert(isAll: Bool){
        var title = "К сожалению, aкция завершилась"
        if isAll{
            title = "К сожалению, все aкции завершились"
        }
        
        let alert = UIAlertController(title: "Внимание", message: title, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { (_) in
            if isAll{
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        imageHeader.sd_setImage(with: url, completed: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK:- Share
        if let identifier = segue.identifier, identifier == SegueID.share.id{
            if let dvc = segue.destination as? ShareViewController{
                dvc.shareViewModel = ShareViewModel(shareType: .stocks)
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func endTimer() {
        if let timer = timer{
            timer.invalidate()
        }
    }
    
    
    //MARK:- Timer Update
    @objc private func updateTime() {
        for indexPath in tableView.indexPathsForVisibleRows ?? []{
            let cell = tableView.cellForRow(at: indexPath) as? AboutStockTableViewCell
            cell?.timerTick()
        }
        
        
        let stocks = tabBarVC.stocks
        var newActions = [StocksActions]()
        var removeActions = [StocksActions]()
        for st in stocks.value?.actions ?? []{
            if let dFormat = getEndTime(strData: st.date_end){
                if dFormat.timeIntervalSince1970 - Date().timeIntervalSince1970 > 0{
                    newActions.append(st)
                }else{
                    removeActions.append(st)
                }
            }else{
                removeActions.append(st)
            }
        }
        
        if removeActions.count > 0{
            stocks.value?.actions = newActions
            stocks.accept(stocks.value)
        }
    }
    
    private func getEndTime(strData: String?) -> Date?{
        if let dTime = strData{
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: dTime){
                return date
            }
        }
        return nil
    }
    
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share(_ sender: UIButton){
        self.view.endEditing(true)
        performSegue(withIdentifier: SegueID.share.id, sender: nil)
    }
    
    
    //MARK:- deinit
    deinit{
        print("AboutStockViewController is deinit")
    }
}

//MARK:- Table View
extension AboutStockViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutStock") as! AboutStockTableViewCell
        cell.dataStock = stockCellViewModel
        return cell
    }
    
}
