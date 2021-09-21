//
//  FlipCardsGame.swift
//  FlipCards
//
//  Created by Алексей Лосев on 07.03.2021.
//

import Foundation

class FlipCardsGame {
    
    private(set) var cards = [Card]()
    
   private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard( at index:Int) {
        if !cards[index].isMatched{
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex] .isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        
    }
    init(numberOfPairsCards: Int) {
        for _ in 1...numberOfPairsCards {
            let card = Card()
            cards += [card,card]
        }
        
    }
}
 
 
