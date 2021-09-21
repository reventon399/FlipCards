//
//  ViewController.swift
//  FlipCards
//
//  Created by Алексей Лосев on 07.03.2021.
//

import UIKit

class ViewController: UIViewController {

  private lazy var game = FlipCardsGame(numberOfPairsCards: numberOfPairsCards)
    
    var numberOfPairsCards: Int {
        return (ButtonCollection.count + 1) / 2
    }
    
    
   private (set) var touches = 0 {
        didSet {       //наблюдатель за изменением значения переменной
            TouchLabel.text = "Touches: \(touches)"
        }
    }
    
    
    
    private var emojiCollection = ["🦊","🐰","🦊","🐰","🐱","🦅","🐥","🦍","🐊","🦒","🦜","🐁 "] // массив эмодзи
        
  private  var emojiDictionary = [Int:String]()
    
  private  func emojiIdentidier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.ark4RandomExtension)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    
  private  func updateViewFromModel() {
        for index in ButtonCollection.indices {
            let button = ButtonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentidier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                button.setTitle("", for: .normal )
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.6657413149, green: 0.5681830112, blue: 1, alpha: 1)
            }
        }
    }
    
    @IBOutlet private var ButtonCollection: [UIButton]!
    @IBOutlet private weak var TouchLabel: UILabel!
    @IBAction private func ButtonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = ButtonCollection.firstIndex(of: sender) { //инструкция как переворачивать карточки
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
        
    }
    
}
  
extension Int {
    var ark4RandomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
                return -Int(arc4random_uniform(UInt32(abs(self))))
            } else {
                return 0
            }
        }
      
    }
extension Array {
    mutating func shuffle() {
        for _ in 0...self.count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

