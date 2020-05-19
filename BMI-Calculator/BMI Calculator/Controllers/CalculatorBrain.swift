//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Bikash das on 19/5/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    var bmi:BMI? = nil
    
    mutating func calculateBMI(height:Float,weight:Int) {
        let bmiVal = Float(weight)/pow(height, 2.0)
        bmi = BMI(bmiValue: bmiVal)
    }
    
    func getBMIValue() -> String {
//        if let bmiVal = bmi {
//            return String(format: "%.02f", bmiVal)
//        }
//        return ""
//        let bmiVal = bmi ?? 0.0
        return String(format: "%.02f", bmi?.value ?? 0.0)
    }
}
