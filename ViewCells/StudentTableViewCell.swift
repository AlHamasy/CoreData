//
//  StudentTableViewCell.swift
//  CoreDataDemo
//
//  Created by asad on 14/05/19.
//  Copyright © 2019 imastudio. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var noHpLabel: UILabel!
    @IBOutlet weak var jenjangLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
