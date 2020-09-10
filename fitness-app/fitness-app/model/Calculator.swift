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
    //let roundedBmiValue = round((100*bmiValue))/100
    
    if bmiValue < 18.5 {
        //bmi = BMI(value: String(format: "%.1f", bmiValue), advice: "Eat more Pies!", colour: UIColor.blue)
        result = Results(sender: "bmi", value: String(format: "%.1f", bmiValue), advice: "Eat more", colour: UIColor.blue)
    }
    else if bmiValue < 24.9 {
        //bmi = BMI(value: String(format: "%.1f", bmiValue), advice: "Fit as a Pie!", colour: UIColor.green)
        result = Results(sender: "bmi", value: String(format: "%.1f", bmiValue), advice: "Good Job!", colour: UIColor.green)
    }
    else {
        //bmi = BMI(value: String(format: "%.1f", bmiValue), advice: "Eat less Pies!", colour: UIColor.red)
        result = Results(sender: "bmi", value: String(format: "%.1f", bmiValue), advice: "Fatty!", colour: UIColor.red)
    }
        
        
    }
    
    
    mutating func bmrCalc(weight:Double, height:Double, age:Double, gender: String) {
        if gender == "Male" {
            let bmrValue = round((10*weight) + (6.25*height) - (5*age) + 5)
            result = Results(sender: "bmr", value: String(format: "%.0f", bmrValue), advice: "This is how much your body needs", colour: UIColor.blue)
            //bmr = BMR(value: String(format: "%.0f", bmrValue), advice: "This is how much your body needs", colour: UIColor.blue)
            
            
        }else {
            let bmrValue = round((10*weight) + (6.25*height) - (5*age) - 161)
            result = Results(sender: "bmr", value: String(format: "%.0f", bmrValue), advice: "This is how much your body needs", colour: UIColor.blue)
            //bmr = BMR(value: String(format: "%.1f", bmrValue), advice: "This is how much your body needs", colour: UIColor.blue)
           
        }
        
    }
    
    
    mutating func tdeeCalc(weight:Double, height:Double, age:Double, gender: String, multiplyer:Double) {
   
        if gender == "Male" {
            let bmr = (10*weight) + (6.25*height) - (5*age) + 5
            let tdee = round(bmr*multiplyer)
            result = Results(sender: "tdee", value: String(format: "%.0f", tdee), advice: "Fast Boi", colour: UIColor.blue)

            
        } else {
            let bmr = (10*weight) + (6.25*height) - (5*age) - 161
            let tdee = round(bmr*multiplyer)
            result = Results(sender: "tdee", value: String(format: "%.0f", tdee), advice: "Fast Boi", colour: UIColor.blue)

        }
        
    }
    
    
}
