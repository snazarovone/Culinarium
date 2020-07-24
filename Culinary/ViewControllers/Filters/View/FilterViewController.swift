//
//  FilterViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 30.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var filterViewModel: FilterViewModel!
    
    var isNewFilter: (()->())? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 100.0, right: 0.0)
        
    }
    
    //MARK:- Actions
    @IBAction func close(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIButton){
        filterViewModel.applyNewFilters()
        isNewFilter?()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- deinit
    deinit{
        print("FilterViewController is deinit")
    }
    
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate{
 
    func toggleSection(header: FilterCollapsibleTableViewHeader, section: Int) {
        let collapsed = !filterViewModel.sectionCollapsed(at: section)
            
        // Toggle collapse
        filterViewModel.setCollapsed(at: section, collapsed: collapsed)
        header.setCollapsed(with: true, collapsed: collapsed)
        
        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return filterViewModel.sectionCollapsed(at: (indexPath as NSIndexPath).section)  ? 0 : UITableView.automaticDimension
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterViewModel.numberSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.filter.identifire) as! FilterTableViewCell
        
        cell.dataFilter = filterViewModel.cellForRow(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let header = UIView.viewFromNibName(name: "FilterHeader") as! FilterCollapsibleTableViewHeader

        if section == 0 {
            header.hideSeparator()
        }else{
            header.showSeparator()
        }
        
        header.name.text = filterViewModel.headerName(at: section)
        header.setCollapsed(with: false, collapsed: filterViewModel.sectionCollapsed(at: section))
        header.section = section
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 48.0
        }
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterViewModel.toogleField(at: indexPath)
        
        tableView.reloadData()
    }
}


