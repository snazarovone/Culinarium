//
//  ParalaxUITableView.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class ParalaxUITableView: UITableView {
    
    var heightConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        if heightConstraint == nil {
            if let imageView = header.subviews.first as? UIImageView {
                heightConstraint = imageView.constraints.filter{ $0.identifier == "height" }.first
                bottomConstraint = header.constraints.filter{ $0.identifier == "bottom" }.first
            }
        }
        
        /// contentOffset - is a dynamic value from the top
        /// adjustedContentInset fixed valie from the top
        let offsetY = -contentOffset.y// + adjustedContentInset.top)
        
        heightConstraint?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        bottomConstraint?.constant = offsetY >= 0 ? 0 : offsetY / 2
        
        header.clipsToBounds = offsetY <= 0
    }
}
