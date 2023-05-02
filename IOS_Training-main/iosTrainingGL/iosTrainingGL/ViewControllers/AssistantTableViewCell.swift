//
//  AssistantTableViewCell.swift
//  iosTrainingGL
//
//  Created by prk on 19/04/23.
//

import UIKit

class AssistantTableViewCell: UITableViewCell {

    
    @IBOutlet var initialtxt: UITextField!
    
    var updateHandler = {
        
    }
    
    var deleteHandler = {
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        deleteHandler()
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        updateHandler()
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
