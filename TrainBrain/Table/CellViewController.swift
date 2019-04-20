//
//  ColorsTableViewCell.swift
//  TableMaker
//
//  Created by Роман Чулкевич on 19/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import UIKit

class CellViewController: UITableViewCell {
    
    @IBOutlet weak var numberButton: UIButton!
    
    func setup(with name: String) {
        numberButton.setTitle(name, for: .normal)
    }
    
}
