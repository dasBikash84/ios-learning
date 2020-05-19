//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightLabelValue: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    private var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func heightSliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        heightLabel.text = String(format: "%.02fm",sender.value)
    }
    
    @IBAction func weightSliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        weightLabelValue.text = "\(Int(sender.value))Kg"
    }
    
    @IBAction func calculateBmi(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        calculatorBrain.calculateBMI(height:height,weight:Int(weight))
        print(calculatorBrain.getBMIValue())
        
        self.performSegue(withIdentifier:"goToResult",sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destVc = segue.destination as! ResultViewController
            destVc.bmi = calculatorBrain.bmi
        }
    }

}

