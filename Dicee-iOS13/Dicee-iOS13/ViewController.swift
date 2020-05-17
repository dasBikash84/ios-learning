//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    let diceImages = [#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")]
    
    var leftPosition = 0
    var rightPosition = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        refreshDices()
        showRandDice()
        diceImageView2.alpha = 0.75
    }

    @IBAction func buttonRoll(_ sender: UIButton) {
//        refreshDices()
        showRandDice()
    }
    
    func refreshDices(){
        leftPosition += 1
        rightPosition += 1
        print("leftPosition: \(leftPosition) rightPosition: \(rightPosition)")
        diceImageView1.image = diceImages[leftPosition%6]
        diceImageView2.image = diceImages[5 - (leftPosition%6)]
        
    }
    
    func showRandDice(){
        diceImageView1.image = diceImages[Int.random(in: 0...5)]
        diceImageView2.image = diceImages[Int.random(in: 0...5)]
    }
}

