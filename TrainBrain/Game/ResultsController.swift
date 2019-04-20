//
//  ResultsController.swift
//  TrainBrain
//
//  Created by Роман Чулкевич on 20/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import Foundation

class ResultsController {
    
    let databaseKey = "gameResults"
    
    func save(_ result: GameResult) {
        // не успел разобраться, как сохранить массив кастомных объектов, поэтому костыль
        let encodedResult = [result.game_date, String(result.game_duration), String(result.total_clicks)]
        // если результаты есть - добавляем
        if var allResults = getAllResults() {
            allResults.append(encodedResult)
            UserDefaults.standard.set(allResults, forKey: self.databaseKey)
        // иначе просто записываем массив из одного - текущего
        } else {
            UserDefaults.standard.set([encodedResult], forKey: self.databaseKey)
        }
    }
    
    func getAllResults() -> [[String]]? {
        let results: [[String]]? = UserDefaults.standard.object(forKey: self.databaseKey) as? [[String]]
        return results
    }
    
}
