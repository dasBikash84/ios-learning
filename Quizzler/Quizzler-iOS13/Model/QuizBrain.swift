//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Bikash das on 19/5/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    
    var questionnumber = 0
    var score = 0
    
    let quiz = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    
    mutating func incQuestionNumber(){
        questionnumber = (questionnumber+1) % quiz.count
        if questionnumber == 0{
            score = 0
        }
    }
    
    private func getCurrentQuestion() -> Question {
        return quiz[questionnumber]
    }
    
    func getOptions() -> [String] {
        return quiz[questionnumber].answers
    }
    
    func getCompletionRatio() -> Float {
        return Float(questionnumber+1)/Float(quiz.count)
    }
    
    mutating func checkAnswer(answer:String) -> Bool {
        let result = getCurrentQuestion().answer == answer
        if result {
            score += 1
        }
        return result
    }
    
    func getQuestionText() -> String{
        return getCurrentQuestion().text
    }
    
    func getCurrentScore() -> Int{
        return score
    }
}
