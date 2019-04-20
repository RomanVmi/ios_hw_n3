//
//  CellViewController.swift
//  TableMaker
//
//  Created by Роман Чулкевич on 19/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import UIKit

class CellValueViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    var cellLabelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = cellLabelText
    }

}
