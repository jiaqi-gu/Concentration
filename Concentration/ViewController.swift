//
//  ViewController.swift
//  Concentration
//
//  Created by Mr Gu on 03/01/2018.
//  Copyright © 2018 Jiaqi Gu. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //lazy var game = Concentration(num: (UIButtons.count + 1) / 2)
    private lazy var game = Concentration(num: num)
    
    var num: Int
    {
        get
        {
            return (UIButtons.count + 1) / 2
        }
    }
    
    //var flipCount: Int = 0
    var flipCount = 0
    {
        didSet
        {
            FlipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var FlipCountLabel: UILabel!
    
    @IBOutlet var UIButtons: [UIButton]!
    
    private var emojiChoicesOrigin = ["🐷","🐎","🐂","🐘","🐱","🎩","🐶","👻","🦊","🐸"]
    var emojiChoices = ["🐷","🐎","🐂","🐘","🐱","🎩","🐶","👻","🦊","🐸"]
    
    
    @IBAction func NewGame(_ sender: UIButton)
    {
        NewGame()
    }
    
    func NewGame()
    {
        game = Concentration(num: (UIButtons.count + 1) / 2)
        emojiChoices = emojiChoicesOrigin
        flipCount = 0
        updateViewFromModel()
    }
    
    @IBAction private func TouchCard(_ sender: UIButton)
    {
        if let cardNumber = UIButtons.index(of: sender)
        {
            //print(cardNumber)
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            if game.chooseCard(at: cardNumber)
            {
                flipCount+=1
            }
            updateViewFromModel()
        }
        else
        {
            print("Not in UIButtons")
        }
    }
    
    private func updateViewFromModel()
    {
        for index in UIButtons.indices
        {
            let button = UIButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) :#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    //var emoji = Dictionary<Int, String>()
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, emojiChoices.count > 0
        {
            //let randomIndex = Int( arc4random_uniform(UInt32(emojiChoices.count)) )
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }

}

extension Int
{
    var arc4random: Int
    {
        if self > 0
        {
            return Int( arc4random_uniform(UInt32(self)) )
        }
        return -Int( arc4random_uniform(UInt32(abs(self))) )
    }
}
