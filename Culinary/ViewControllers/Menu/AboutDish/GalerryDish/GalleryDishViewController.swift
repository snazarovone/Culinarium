//
//  GalleryDishViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class GalleryDishViewController: UIViewController {
    
    @IBOutlet weak var arrowUpView: ArrowUpUIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var bottomTitleView: NSLayoutConstraint! //-200
    @IBOutlet weak var bottomCollectionView: NSLayoutConstraint!
    @IBOutlet weak var topCollectionView: NSLayoutConstraint!
    
    //PUBLIC
    var galleryDishViewModel: GalleryDishViewModel!
    public var endShow: (()->())? = nil
    
    //Animate collection parallax
    private var direction: UICollectionView.ScrollDirection = .horizontal
    private let animator: LayoutAttributesAnimator = (ParallaxAttributesAnimator())
 
    fileprivate var tap: UITapGestureRecognizer!
    fileprivate var marginHeight: CGFloat = 0.0
    fileprivate var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = galleryDishViewModel.numberOfRow()

        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
            layout.scrollDirection = direction
            layout.animator = animator
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        bottomCollectionView.constant = 500
//        UIView.animate(withDuration: 2.0) {
//            self.view.layoutIfNeeded()
//            self.collectionView.performBatchUpdates(nil, completion: nil)
//        }
    }
    
    
    @IBAction func back(_ sender: UIButton){
        self.endShow?()
        dismiss(animated: false, completion: nil)
    }
    
    //MARK:- Actions
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.viewTitle.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            let r = touchPoint.y - initialTouchPoint.y + 200
            if r <= 200 && r >= 64{
                bottomTitleView.constant = -r
                
                bottomCollectionView.constant = 66 - (touchPoint.y - initialTouchPoint.y)
                topCollectionView.constant =  (touchPoint.y - initialTouchPoint.y)
                
                let alpha = (r - 64.0)/136.0
//                self.collectionView.alpha = alpha
                
                //Arrow
                self.arrowUpView.centerBottom = Double((1-alpha) * 5) + 7.13
                self.arrowUpView.setNeedsDisplay()
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            let r = touchPoint.y - initialTouchPoint.y + 200
            if r > 128{
                bottomTitleView.constant = -200
                
                bottomCollectionView.constant = 66.0
                topCollectionView.constant =  0.0
                
                //Arrow
                self.arrowUpView.centerBottom = 7.13
                UIView.animate(withDuration: 0.5) {
//                    self.collectionView.alpha = 1.0
                    self.view.layoutIfNeeded()
                    self.arrowUpView.setNeedsDisplay()
                }
            }else{
                bottomTitleView.constant = 0
                
                bottomCollectionView.constant = 266.0
                topCollectionView.constant =  -266.0
                
                //Arrow
                self.arrowUpView.centerBottom = 12.0
                UIView.animate(withDuration: 0.4, animations: {
//                    self.collectionView.alpha = 0.0
                    self.view.layoutIfNeeded()
                    self.arrowUpView.setNeedsDisplay()
                    
                    self.collectionView.alpha = 0.0
                    self.viewTitle.alpha = 0.0
                    self.endShow?()
                }) { (_) in
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    
    
    //MARK:- Deinit
    deinit{
        print("GalleryDishViewController")
    }
    
}

extension GalleryDishViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryDishViewModel.numberOfRow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.galleryDish.identifire, for: indexPath) as! DishCollectionViewCell
        cell.dataDish = galleryDishViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return false
    }
}

extension GalleryDishViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension GalleryDishViewController: UIGestureRecognizerDelegate{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith
        otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
