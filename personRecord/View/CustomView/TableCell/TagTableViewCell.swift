//
//  TagTableViewCell.swift
//  personRecord
//
//  Created by 竹内愛実 on 2021/05/26.
//

import UIKit

class TagTableViewCell: UITableViewCell {

    @IBOutlet weak var labelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCategoryname(_ category: Category){
        
        let state = UIControl.State.normal
        labelButton.setTitle(category.categoryName, for: state)
        
    }
    
}
