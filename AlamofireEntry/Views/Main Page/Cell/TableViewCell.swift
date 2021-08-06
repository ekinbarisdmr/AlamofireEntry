//
//  TableViewCell.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 14.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 16
        
    }

  
    
}
