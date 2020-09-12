//
//  bmrCalculator.swift
//  fitness-app
//
//  Created by Steve Jones on 06/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

struct Calculator{
    
    var result: Results?
    
    mutating func bmiCalc(weight:Double, height:Double) {
        let bmiValue = round((10*weight / (height*height)))/10
        if bmiValue < 18.5 {
            result = Results(sender: K.Bmi.sender, value: String(format: "%.1f", bmiValue), advice: K.Bmi.Advice.underweight, colour: K.Bmi.underweightColor!)
        } else if bmiValue < 24.9 {
            result = Results(sender: K.Bmi.sender, value: String(format: "%.1f", bmiValue), advice: K.Bmi.Advice.normal, colour: K.Bmi.normalColor!)
        } else if bmiValue < 29.9 {
            result = Results(sender: K.Bmi.sender, value: String(format: "%.1f", bmiValue), advice: K.Bmi.Advice.overweight, colour: K.Bmi.overweightColor!)
        } else {
            result = Results(sender: K.Bmi.sender, value: String(format: "%.1f", bmiValue), advice: K.Bmi.Advice.obese, colour: K.Bmi.obeseColor!)
        }
    }
    
    
    mutating func bmrCalc(weight:Double, height:Double, age:Double, gender: String) {
        if gender == "Male" {
            let bmrValue = round((10*weight) + (6.25*height) - (5*age) + 5)
            result = Results(sender: K.Bmr.sender, value: String(format: "%.0f", bmrValue), advice: K.Bmr.advice, colour: K.Bmr.color!)

        } else {
            let bmrValue = round((10*weight) + (6.25*height) - (5*age) - 161)
            result = Results(sender: K.Bmr.sender, value: String(format: "%.0f", bmrValue), advice: K.Bmr.advice, colour: K.Bmr.color!)
        }
        
    }
    
    
    mutating func tdeeCalc(weight:Double, height:Double, age:Double, gender: String, multiplyer:Double) {
        if gender == "Male" {
            let bmr = (10*weight) + (6.25*height) - (5*age) + 5
            let tdee = round(bmr*multiplyer)
            result = Results(sender: K.Tdee.sender, value: String(format: "%.0f", tdee), advice: K.Tdee.advice, colour: K.Tdee.color!)
        } else {
            let bmr = (10*weight) + (6.25*height) - (5*age) - 161
            let tdee = round(bmr*multiplyer)
            result = Results(sender: K.Tdee.sender, value: String(format: "%.0f", tdee), advice: "Fast Boi", colour: K.Tdee.color!)
        }
    }
}
