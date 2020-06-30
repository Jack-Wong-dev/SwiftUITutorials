//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Jack Wong on 5/27/20.
//  Copyright © 2020 Jack Wong. All rights reserved.
//

import SwiftUI

/**View Models should be classes
 Doorway for the view to get to the model
 Why classes?  It's easy to share.  Classes live in a heap, and it has pointers to it.
 Disadvantage:  One rogue view can make changes and messes it up for every other view.
 **/

class EmojiMemoryGame: ObservableObject  {
    //    private(set) var game: MemoryGame<String> //private(set) Only EmojiMemoryGame modify this.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: [String] = ["👻","🎃","🕷"]
        return MemoryGame<String>(numberOfPairOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    
}
