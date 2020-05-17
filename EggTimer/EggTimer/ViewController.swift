//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes :[String:Int] = ["Soft": 5, "Medium":7,"Hard":12]
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    private let defaultTitleText = "How do you like your eggs?"
    private var busyCooking = false
    private var currentCookingTime = 0
    
    override func viewDidLoad() {
        progressBar.isHidden = true
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        if !busyCooking {
            busyCooking = true
            let buttonText = sender.currentTitle!
            
//            print("Starting to cook \(buttonText) egg.")
            titleLabel.text = "Starting to cook \(buttonText) egg."
            progressBar.progress = 0.0
            progressBar.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.currentCookingTime = self.eggTimes[buttonText]!
                self.showRemainingTime(secsRemaining: self.currentCookingTime)
            })
        }else{
            print("Busy now!!")
        }
    }
    
    func showRemainingTime(secsRemaining:Int){
        if secsRemaining > 0 {
            titleLabel.text = "\(secsRemaining) seconds remaining."
            progressBar.progress = 1 - Float(secsRemaining)/Float(currentCookingTime)
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.showRemainingTime(secsRemaining: secsRemaining-1)
            })
        }else{
            titleLabel.text = "Done"
            progressBar.progress = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.titleLabel.text = self.defaultTitleText
                self.busyCooking = false
                self.progressBar.isHidden = true
            })
        }
    }
    

}
