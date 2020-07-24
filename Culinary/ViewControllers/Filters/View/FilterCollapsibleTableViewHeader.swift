//
//  FilterCollapsibleTableViewHeader.swift
//  Culinary
//
//  Created by Sergey Nazarov on 30.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FilterCollapsibleTableViewHeader: UITableViewHeaderFooterView {
 
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader(gestureRecognizer:))))
    }
    
    @objc func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? FilterCollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func setCollapsed(with animation: Bool, collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        if animation{
            arrow.rotate(collapsed ? 0.0 : .pi)
        }else{
            arrow.transform = arrow.transform.rotated(by: collapsed ? 0.0 : .pi)
        }
    }
    
    func hideSeparator(){
        topConstraint.constant = 24.0
        separatorView.isHidden = true
    }
    
    func showSeparator(){
        topConstraint.constant = 40.0
        separatorView.isHidden = false
    }
}

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: FilterCollapsibleTableViewHeader, section: Int)
}

