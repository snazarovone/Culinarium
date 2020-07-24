//
//  HeaderDishViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class HeaderDishViewController: UIViewController {
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageDish: UIImageView!
    @IBOutlet weak var titleView: UIView!
    var bannerInitialHeight: CGFloat!
    var bannerInitialCenterY: CGFloat!
    @IBOutlet weak var heightWeght: NSLayoutConstraint!
    @IBOutlet weak var heightViewTitile: NSLayoutConstraint!
    @IBOutlet weak var titleDish: UILabel!
    @IBOutlet weak var priceDish: UILabel!
    @IBOutlet weak var currencyDIsh: UILabel!
    @IBOutlet weak var oldPriceDish: UILabel!
    @IBOutlet weak var arrowView: ArrowUpUIView!
    
    @IBOutlet weak var viewCountInBasket: UIView! //isHide default
    @IBOutlet weak var countInBasket: UILabel!
    
    //PRIVATE
    private var headerDishViewModel: HeaderDishViewModel!
    private let disposeBag = DisposeBag()
    
    public var endShow: (()->())? = nil
    public var dish: DisheModel!
    public var selectPortion: BehaviorRelay<PortionsDish?> = BehaviorRelay(value: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerDishViewModel = HeaderDishViewModel(portions: dish.portions ?? [], selectPortion: selectPortion.value)
        
        
        titleDish.text = dish.title
        currencyDIsh.text = "₽"
        priceDishAt(portion: 0)
        setupImageDish()
        
        selectPortion.asObservable().subscribe(onNext: { [weak self] (value) in
            if let indexPath = self?.headerDishViewModel.getSelectRow(at: value){
                //обновляем цену в зависимости от выбранной порции
                self?.priceDishAt(portion: indexPath.row)
                self?.collectionView.reloadData()
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectPortion.accept(headerDishViewModel.getPortion())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if bannerInitialCenterY == nil{
            bannerInitialCenterY = bannerView.center.y
        }
        
        if bannerInitialHeight == nil{
            bannerInitialHeight = bannerView.frame.height
        }
        
    }
    
    private func setupImageDish(){
        let url = URL(string: dish.preview_image ?? "")
        imageDish.sd_setImage(with: url, completed: nil)
    }
    
    func adjustBannerView(with progress: CGFloat, headerHeight: ClosedRange<CGFloat>){
        let y = progress * (headerHeight.upperBound - headerHeight.lowerBound)
        let topLimit = bannerInitialHeight - headerHeight.lowerBound
        if y > topLimit{
            bannerView.center.y = bannerInitialCenterY + y - topLimit
        }else{
            bannerView.center.y = bannerInitialCenterY
        }
        if y <= 10 && heightWeght.constant != 32{
            heightWeght.constant = 32.0
            heightViewTitile.constant = heightViewTitile.constant + 58
            
            titleDish.font = UIFont(name:"Rubik-Medium", size:22.0)!
            priceDish.font = UIFont(name:"Rubik-Medium", size:22.0)!
            currencyDIsh.font = UIFont(name:"Rubik-Regular", size:13.0)!
            oldPriceDish.font = UIFont(name:"Rubik-Regular", size:13.0)!
            
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            
        }else{
            if y >= 10 && heightWeght.constant != 0.0{
                heightWeght.constant = 0.0
                heightViewTitile.constant = heightViewTitile.constant - 58
                
                titleDish.font = UIFont(name:"Rubik-Medium", size:16.0)!
                priceDish.font = UIFont(name:"Rubik-Medium", size:18.0)!
                currencyDIsh.font = UIFont(name:"Rubik-Regular", size:10.0)!
                oldPriceDish.font = UIFont(name:"Rubik-Regular", size:10.0)!
                
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        
        //Arrow
        if progress > 0.0{
            arrowView.centerBottom = Double(progress * 8) + 7.13
            arrowView.setNeedsDisplay()
        }
        
    }
    
    public func showGallery(){
        performSegue(withIdentifier: SegueID.galleryDish.id, sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.galleryDish.id{
            if let dvc = segue.destination as? GalleryDishViewController{
                
                //dataSourse
                dvc.galleryDishViewModel = GalleryDishViewModel(gallery: dish.gallery ?? [])
                
                dvc.endShow = {
                    [weak self] in
                    self?.endShow?()
                }
            }
            return
        }
    }
    
    
    
    
    //MARK:- Actions
    @IBAction func showImages(_ sender: UIButton){
        showGallery()
    }
    
    //MARK:- deinit
    deinit{
        print("HeaderDishViewController is deinit")
    }
}

extension HeaderDishViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerDishViewModel.numberOfRow(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.wightEatID.identifire, for: indexPath) as! WightEatCollectionViewCell
        cell.dataWight = headerDishViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        headerDishViewModel.didSelectRow(at: indexPath)
        //передаем id выбранной порции для добавления в корзину
        self.selectPortion.accept(headerDishViewModel.getPortion())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = headerDishViewModel.getWightTextAt(indexPath: indexPath)
        return CGSize(width: width, height: 32.0)
    }
    
    //MARK:- PriceDish
    private func priceDishAt(portion index: Int){
        if index < dish.portions?.count ?? 0{
            if let p = dish.portions?[index], let price = p.price{
                if let discont = dish.discount, discont != 0{
                    
                    let attributedString = NSAttributedString(string: "\(price)", attributes:[NSAttributedString.Key.strikethroughStyle:1.0,NSAttributedString.Key.strikethroughColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0),NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:10.0)!,NSAttributedString.Key.foregroundColor:UIColor(red:0.37, green:0.347, blue:0.334, alpha:1.0)])
                    oldPriceDish.attributedText = attributedString
                    
                    let nPrice = String(price - Int((price * discont) / 100))
                    self.priceDish.text = nPrice
                }else{
                    self.priceDish.text = "\(price)"
                    self.oldPriceDish.text = nil
                }
                return
            }
        }
        self.priceDish.text = nil
        self.oldPriceDish.text = nil
        self.currencyDIsh.text = nil
    }
}

//MARK:- BasketDelegate
extension HeaderDishViewController: AboutDishBasketDelegate{
    func inBasket(count: Int) {
        if count > 1{
            countInBasket.text = "\(count)"
            viewCountInBasket.isHidden = false
        }else{
            viewCountInBasket.isHidden = true
        }
        
        if count == 0 {
            collectionView.isUserInteractionEnabled = true
            self.collectionView.alpha = 1.0
        }else{
            collectionView.isUserInteractionEnabled = false
            if self.collectionView.alpha == 1.0{
                UIView.animate(withDuration: 0.6) {
                    self.collectionView.alpha = 0.4
                }
            }
        }
    }
}
