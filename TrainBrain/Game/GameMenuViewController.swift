//
//  GameViewController.swift
//  TrainBrain
//
//  Created by Роман Чулкевич on 19/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import UIKit

class GameMenuViewController: UIViewController {

    @IBAction func playButtonAction(_ sender: Any) {

        let gameViewController = GameViewController.instance()
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @IBAction func resultsButtonAction(_ sender: Any) {
        let resultsController = ResultsController()
        let allResults = resultsController.getAllResults() ?? [[""]]
        // to do: рефактор [2] в .total_clicks (т.к. сейчас возвращаются массивы строк)
        let sortedResults = allResults.sorted {
            $0[2] < $1[2]
        }
        let preparedToShowResults = sortedResults.enumerated().map({"\($0 + 1)) \t" + $1[2] + "\t\($1[1])сек" + "\t(\($1[0]))"})
        let resultsViewController = TableViewController.tableInstance("Результаты игр", preparedToShowResults, "\tКликов\tВремя игры\tДата")
        self.navigationController?.pushViewController(resultsViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
