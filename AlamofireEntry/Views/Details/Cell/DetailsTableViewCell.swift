//
//  DetailsTableViewCell.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 15.05.2021.
//

import Foundation
import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    
    var tapButton: () -> ()  = { }
    

    override func awakeFromNib() {
        super.awakeFromNib()

        let tap = UITapGestureRecognizer(target: self, action: #selector(showLink(sender:)))
        linkLabel.addGestureRecognizer(tap)
        colorView.backgroundColor = UIColor.customColor()
        colorView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        showButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func showButton(_ sender: Any) {
       tapButton()
    }
    
    @objc func showLink(sender: UITapGestureRecognizer) {
        
    }
    
}
