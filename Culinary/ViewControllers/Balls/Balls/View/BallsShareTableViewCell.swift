//
//  BallsShareTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 07.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsShareTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageViewDesignable!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var countBall: UILabel!
    
    private weak var shareDelegate: BallsShareDelegate?
    
    weak var dataShare: BallsShareCellViewModelType?{
        willSet(data){
            self.shareDelegate = data?.shareDelegate
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func vk(_ sender: UIButton) {
        self.shareDelegate?.vk()
    }
    
    @IBAction func fb(_ sender: UIButton) {
        self.shareDelegate?.fb()
    }
    
    @IBAction func instagramm(_ sender: UIButton) {
        self.shareDelegate?.instagramm()
    }
}
