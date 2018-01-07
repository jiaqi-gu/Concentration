//
//  Concentration.swift
//  Concentration
//
//  Created by Mr Gu on 04/01/2018.
//  Copyright © 2018 Jiaqi Gu. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    var indexOfOneAndFaceUpCard: Int?
    {
        get
        {
            var foundIndex: Int?
            for index in cards.indices
            {
                if cards[index].isFaceUp
                {
                    if foundIndex == nil
                    {
                        foundIndex = index
                    }
                    else
                    {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set
        {
            for index in cards.indices
            {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) -> Bool
    {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index)): chosen index not in the cards")
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfOneAndFaceUpCard, matchIndex != index
            {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                //usleep(500000)
                //cards[matchIndex].isFaceUp = false
                //cards[index].isFaceUp = false
                
                //indexOfOneAndFaceUpCard = nil
            }
            else
            {
                // either no cards or 2 cards face up
//                for flipDownIndex in cards.indices
//                {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndFaceUpCard = index
            }
            return true
        }
        return false
    }
    
    init(num: Int)
    {
        assert(num > 0, "At least 1 card")
        for _ in 1...num
        {
            let card = Card()
//            cards.append(card)
//            cards.append(card)
            cards += [card,card]
        }
        
        // Shuffle
        for i in 0...(num-1)
        {
            let newIndex = Int(arc4random_uniform(UInt32(i+1)))
            // Swap
            let tempValue = cards[newIndex]
            cards[newIndex] = cards[i]
            cards[i] = tempValue
        }
    }
}
