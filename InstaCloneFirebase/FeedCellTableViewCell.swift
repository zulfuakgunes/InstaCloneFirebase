//
//  FeedCellTableViewCell.swift
//  InstaCloneFirebase
//
//  Created by Zülfü Akgüneş on 22.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class FeedCellTableViewCell: UITableViewCell {
    @IBOutlet var userEmailText: UILabel!
    
    @IBOutlet var imageViewFeed: UIImageView!
    
    @IBOutlet var commentText: UILabel!
    
    @IBOutlet var likeLabel: UILabel!
    
    
    @IBOutlet var documentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let fireStroreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!){
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            
            fireStroreDatabase.collection("Posts").document(documentLabel.text!).setData(likeStore, merge: true)
        }
        
        
    }
    
}
