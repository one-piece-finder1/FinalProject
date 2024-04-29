//
//  QuoteCell.swift
//  Quote Getter - Final Project
//
//  Created by Sri Nandan Gondi on 22/04/24.
//

import UIKit

class QuoteCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
  
    @IBOutlet weak var saveButton: UIButton!
    
    typealias ButtonAction = (UITableViewCell) -> Void
    
    var onButtonClicked: ButtonAction?
    

    @IBAction func onClickSaveButton(_ sender: Any) {

        
        onButtonClicked?(self)
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
