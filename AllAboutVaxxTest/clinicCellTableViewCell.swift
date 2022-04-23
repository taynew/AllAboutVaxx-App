//
//  clinicCellTableViewCell.swift
//  AllAboutVaxx
//
//  Created by Derrick Duller on 4/22/22.
//

import UIKit

class clinicCellTableViewCell: UITableViewCell {

    @IBOutlet weak var clinicName: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var appointmentLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
