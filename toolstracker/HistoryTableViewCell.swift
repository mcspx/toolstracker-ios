//
//  HistoryTableViewCell.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/24/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit


class HistoryTableViewCell: MGSwipeTableCell {

    @IBOutlet var imgTAT: UIImageView!
    @IBOutlet var lblTATAll: UILabel!
    @IBOutlet var lblDetail: UILabel!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var imgState: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgState.layer.cornerRadius = self.imgState.frame.width / 2
        self.imgState.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
