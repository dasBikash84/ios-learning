//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Bikash das on 19/5/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text:String
    let answers:[String]
    let answer:String
    
    init(q:String,a:[String],correctAnswer:String) {
        self.text = q
        self.answers = a
        self.answer = correctAnswer
    }
}
