//
//  GameViewController.swift
//  TrainBrain
//
//  Created by Роман Чулкевич on 20/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var startGameLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var totalClicksLabel: UILabel!
    
    lazy var game = Memory(numberOfCards: cardButtons.count)
    var gameIsActive = false
    var game_date: Date?
    var resultsController = ResultsController()
    
    
    func saveGameResult() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let gameDate = "\(dateFormatter.string(from: self.game_date!))"
        let gameDuration = Int(Date().timeIntervalSince(self.game_date!))
        let gameResult = GameResult(game_date: gameDate, game_duration: gameDuration, total_clicks: game.total_clicks)
        self.resultsController.save(gameResult)
    }
    
    // Генерация лицевой стороны для всех карт
    func generateFacesForCards() {
        let emojiList = ["🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐵", "🦉", "🦇"]
        // изначально все карты пусты
        var cardsWithEmptyFace = Array(game.cards.indices.startIndex..<game.cards.indices.endIndex)
        
        fillFaces: for emoji in emojiList {
            // каждый смайл должен встречаться дважды
            for _ in 1...2 {
                // выбираем случайную карту и определяем ей смайл для лицевой стороны
                let card = cardsWithEmptyFace.randomElement()!
                game.cards[card].face = emoji
                cardsWithEmptyFace.remove(at: cardsWithEmptyFace.firstIndex(of: card)!)
            }
            // карт не осталось - заполнять больше не нужно
            if cardsWithEmptyFace.isEmpty {
                break fillFaces
            }
        }
    }
    
    // Поворот карты по индексу в ту или иную сторону
    func turnCardFace(at index: Int, to side: String) {
        let button = cardButtons[index]
        if (side == "front") {
            button.setTitle(game.cards[index].face, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.2723996043, green: 0.6819463372, blue: 0.632582128, alpha: 1)
        }
    }
    
    // Вызов функции поворота на определенную сторону для всех карт
    func turnAllCardsFaces(to side: String) {
        for cardIndex in cardButtons.indices {
            turnCardFace(at: cardIndex, to: side)
        }
    }
    
    // Начальные действия при старте игры
    func startGame() {
        gameIsActive = false
        generateFacesForCards()
        // через пару секунд после запуск показываем лэйбл и открываем все карты
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.startGameLabel.isHidden = false
            self.turnAllCardsFaces(to: "front")
        })
        // по истечении 6 секунд скрываем лэйбл и закрываем карты
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
            self.startGameLabel.isHidden = true
            self.turnAllCardsFaces(to: "back")
            self.gameIsActive = true
            self.game_date = Date()
        })
    }
    
    @IBAction func restartButtonAction(_ sender: Any) {
        resetGame()
    }
    
    // Рестарт игры
    func resetGame() {
        turnAllCardsFaces(to: "back")
        for cardIndex in cardButtons.indices {
            game.cards[cardIndex].isMatched = false
            game.cards[cardIndex].isFaceUp = false
        }
        restartButton.isEnabled = false
        startGame()
    }
    
    func updateButtons() {
        // если не осталось нерасрытых карт - активируем кнопку рестарта
        var dontMatchYet = 0
        for index in cardButtons.indices {
            let card = game.cards[index]
            if !card.isMatched {
                dontMatchYet += 1
            }
            if card.isFaceUp {
                turnCardFace(at: index, to: "front")
            } else {
                if !card.isMatched {
                    turnCardFace(at: index, to: "back")
                }
            }
        }
        if (dontMatchYet == 0) {
            restartButton.isEnabled = true
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            saveGameResult()
        }
    }
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if !gameIsActive {
                return
        }
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateButtons()
            totalClicksLabel.text = "Кликов совершено: \(game.total_clicks)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
