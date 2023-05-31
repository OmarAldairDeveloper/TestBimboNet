//
//  MissionCell.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 29/05/23.
//

import UIKit

class MissionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
