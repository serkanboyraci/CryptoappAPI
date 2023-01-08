//
//  Cell.swift
//  Cryptoapp
//
//  Created by Ali serkan Boyracı  on 8.01.2023.
//

import UIKit

class Cell: UITableViewCell {
  
  
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
