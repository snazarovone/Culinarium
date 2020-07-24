//
//  StocksTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StocksTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionStocksHeight: NSLayoutConstraint! // is 144
    @IBOutlet weak var bottomConstarint: NSLayoutConstraint! //is 4 if > 0
    @IBOutlet weak var StockViewHeight: NSLayoutConstraint! // // is 180
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var countBalls: UILabel!
    @IBOutlet weak var viewStocks: UIView!
    @IBOutlet weak var bottomBackgrondConst: NSLayoutConstraint! //is 72
//
    //PRIVATE
    private weak var stocksDelegate: StocksDelegate?
    private let disposeBag = DisposeBag()
    public var stocks: BehaviorRelay<StocksModel?> = BehaviorRelay(value: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    public func subscribe(){
        stocks.asObservable().subscribe(onNext: { [weak self] (value) in
            if value?.actions?.count ?? 0 > 0{
                self?.StockViewHeight.constant = 180.0
                self?.collectionStocksHeight.constant = 144.0
                self?.bottomConstarint.constant = 4.0
                self?.viewStocks.isHidden = false
                self?.bottomBackgrondConst.constant = 72
            }else{
                self?.collectionStocksHeight.constant = 0.0
                self?.StockViewHeight.constant = 0.0
                self?.bottomConstarint.constant = 0.0
                self?.viewStocks.isHidden = true
                self?.bottomBackgrondConst.constant = 56
            }
            self?.collectionView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    weak var dataStock: StocksTableCellViewModelType?{
        willSet(data){
            self.stocksDelegate = data?.stocksDelegate
        }
    }
    
    @IBAction func all(_ sender: UIButton) {
        stocksDelegate?.allStocks()
    }
    
    @IBAction func joinFrend(_ sender: UIButton) {
    }
    
    @IBAction func aboutDelivery(_ sender: UIButton) {
    }
    
    @IBAction func qrCode(_ sender: UIButton) {
        stocksDelegate?.myBalls()
    }
    
    @IBAction func call(_ sender: UIButton) {
        stocksDelegate?.feedback()
    }
    
    @IBAction func profile(_ sender: UIButton) {
        stocksDelegate?.profile()
    }
}

//MARK:- CollectionView
extension StocksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStock?.numberOfItemsInSection(at: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.tabMainCellStocks.identifire, for: indexPath) as! StocksCollectionViewCell
        let dataCell = dataStock?.cellForRow(at: indexPath)
        cell.dataStock = dataCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dataCell = dataStock!.cellForRow(at: indexPath)
        return dataCell.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = StockCellViewModel(stocksAllType: .stocks, stock: stocks.value?.actions?[indexPath.row])
        dataStock!.stockCollectionDelegate?.aboutStock(stockCellViewModel: model)
    }
}
