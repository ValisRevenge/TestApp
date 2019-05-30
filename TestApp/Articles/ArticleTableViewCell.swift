//
//  TableViewCell.swift
//  TestApp
//
//  Created by Mishko on 5/29/19.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(title:String, authors:String) {
        titleLabel.text = title
        authorsLabel.text = authors
    }
    
}
