//
//  HeaderCatMenuViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class HeaderCatMenuViewController: UIViewController {
    
    @IBOutlet weak var eat1: UIImageView!
    @IBOutlet weak var eat2: UIImageView!
    @IBOutlet weak var titleCat: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    
    var titleCatSection: String = ""
    
    var filters = [FiltersSection]()
    var isNewFilter: (()->())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleCat.text = titleCatSection
        
        eat1.layer.zPosition = 2
        titleCat.layer.zPosition = 3
        backBtn.layer.zPosition = 4
        filterBtn.layer.zPosition = 4
        
    }
    
    func adjustBannerView(with progress: CGFloat, headerHeight: ClosedRange<CGFloat>){
            let scale = min(1, (1-progress*1.05))
            let t = CGAffineTransform(scaleX: scale, y: scale)
            eat1.transform = t.translatedBy(x: 0, y: eat1.frame.height*(1 - scale))
            eat2.transform = t.translatedBy(x: 0, y: eat2.frame.height*(1 - scale))
    }
    
    //MARK:- Actions
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filter(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueID.filter.id, sender: nil)
    }
    
    //MARK:- Filters
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.filter.id{
            if let dvc = segue.destination as? FilterViewController{
                dvc.isNewFilter = self.isNewFilter
                dvc.filterViewModel = FilterViewModel(fSections: filters)
            }
        }
    }
    
    
    //MARK:- deinit
    deinit{
        print("HeaderCatMenuViewController is deinit")
    }
}
