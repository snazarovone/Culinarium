//
//  AboutCompanyTableViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class AboutCompanyTableViewController: UITableViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var dataPairs : [UIImage] = [#imageLiteral(resourceName: "minors"), #imageLiteral(resourceName: "galeon"), #imageLiteral(resourceName: "ryba"), #imageLiteral(resourceName: "alko"), #imageLiteral(resourceName: "minors"), #imageLiteral(resourceName: "galeon"), #imageLiteral(resourceName: "ryba"), #imageLiteral(resourceName: "alko"), #imageLiteral(resourceName: "minors"), #imageLiteral(resourceName: "galeon"), #imageLiteral(resourceName: "ryba")]
    private var lastXPosition: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        collectionView.dataSource = self
        collectionView.delegate = self
        
        var countPage = Double(dataPairs.count) / 4.0
        countPage.round(.up)
        
        pageControl.numberOfPages = Int(countPage)
        pageControl.currentPage = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        super.viewWillAppear(animated)
    }
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AboutCompanyTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPairs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.pair.identifire, for: indexPath) as! PairCollectionViewCell
        cell.imgPair.image = dataPairs[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2.0, height: collectionView.bounds.height / 2.0)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != lastXPosition{
            lastXPosition = scrollView.contentOffset.x
        }
        let pageIndex = round(lastXPosition/self.view.bounds.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
}
