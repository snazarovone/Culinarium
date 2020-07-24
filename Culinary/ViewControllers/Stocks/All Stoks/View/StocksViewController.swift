//
//  StocksViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StocksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //PRIVATE
    private weak var timer: Timer?
    private let disposedBag = DisposeBag()
    private var isShowAlert = true
    
    //PUBLIC
    public var stocksViewModel: StocksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        super.viewWillAppear(animated)
        self.title = stocksViewModel.stocksAllType.title
        
        if let timer = timer, timer.isValid == false{
            startTimer()
        }else{
            if timer == nil{
                startTimer()
            }
        }
        
        isShowAlert = true
    }
    
    private func subscribes(){
        stocksViewModel.stocks.asObservable().subscribe(onNext: { [weak self] (value) in
            self?.tableView.reloadData()
            if value?.actions?.count ?? 0 == 0{
                if self?.isShowAlert ?? false{
                    self?.showAlert()
                }
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposedBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endTimer()
        isShowAlert = false
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Внимание", message: "К сожалению, все актуальные акции завершились", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { (_) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,  identifier == SegueID.aboutStock.id{
            if let dvc = segue.destination as? AboutStockViewController{
                dvc.stockCellViewModel = sender as? StockCellViewModel
            }
            return
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
            let cell = tableView.cellForRow(at: indexPath) as? StockTableViewCell
            cell?.timerTick()
        }
        
        
        let stocks = stocksViewModel.stocks
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
    
    
    // MARK: - deinit
    deinit{
        print("StocksViewController is deinit")
    }
}

extension StocksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stocksViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.stock.identifire) as! StockTableViewCell
        cell.dataStock = self.stocksViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let model = self.stocksViewModel.cellForRow(at: indexPath)
            self.performSegue(withIdentifier: SegueID.aboutStock.id, sender: model)
        }
    }
}
