//
//  BMI.swift
//  BMI Calculator
//
//  Created by Bikash das on 19/5/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct BMI {
    
    let value:Float
    let advice:String
    let color:UIColor
    
    init(bmiValue:Float) {
        self.value = bmiValue
        if bmiValue >= 25.0 {
            self.advice = "Eat less pies!"
            self.color = #colorLiteral(red: 0.6145051122, green: 0.1419887841, blue: 0.1185588911, alpha: 1)
        }else if bmiValue > 18.5 {
            self.advice = "Fit as a fiddle!"
            self.color = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }else{
            self.advice = "Eat more pies!"
            self.color = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
    }
}
