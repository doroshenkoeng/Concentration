//
//  ViewController.swift
//  Concentration
//
//  Created by Сергей Дорошенко on 16/07/2019.
//  Copyright © 2019 Сергей Дорошенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var numberOfPairsOfCards: Int {
        return  (cardButtons.count + 1) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()")
        print("Log smth")
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        print("ViewDidAppear Log")
    }

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            }
        }
        game.updateScore()
        scoreCountLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        emojiChoies = themes[Int(arc4random_uniform(UInt32(themes.count)))]
        game.flipCount = 0
        game.score = 0
        scoreCountLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        resetCardButtons()
    }
    
    private func resetCardButtons() {
        for cardButton in cardButtons {
            cardButton.setTitle("", for: UIControl.State.normal)
            cardButton.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }
    }
    
    private var themes =  [
        ["🐅", "🦝", "🦙", "🦔", "🦒", "🦓", "🦘", "🐌", "🐄"],
        ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🏉", "🏓", "⛸"],
        ["😀", "😃", "😄", "😆", "😅", "😂", "🤣", "☺️", "😇"],
        ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓"],
        ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒"],
        ["⌚️", "📱", "📲", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲"]
        ]
    private lazy var emojiChoies = themes[Int(arc4random_uniform(UInt32(themes.count)))]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoies.count > 0 {
            emoji[card.identifier] = emojiChoies.remove(at: emojiChoies.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        get {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            } else if self < 0 {
                return -Int(arc4random_uniform(UInt32(-self)))
            } else {
                return 0
            }
        }
    }
    
}
