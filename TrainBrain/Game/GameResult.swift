//
//  GameResult.swift
//  TrainBrain
//
//  Created by Роман Чулкевич on 20/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import Foundation

class GameResult {
    var game_date: String
    var game_duration: Int //секунды
    var total_clicks: Int
    
    
    init(game_date: String, game_duration: Int, total_clicks: Int) {
        self.game_date = game_date
        self.game_duration = game_duration
        self.total_clicks = total_clicks
    }
}
