//
//  bmrCalculator.swift
//  fitness-app
//
//  Created by Steve Jones on 06/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import Foundation

struct Calculator{
    
    
    func bmiCalc(weight:Double, height:Double) -> Double {
    let bmi = weight / (height*height)
    return round((100*bmi))/100
    }
    
    
    func bmrCalc(weight:Double, height:Double, age:Double, gender: String) -> Double {
        if gender == "Male" {
            let bmr = (10*weight) + (6.25*height) - (5*age) + 5
            return bmr
        } else {
            let bmr = (10*weight) + (6.25*height) - (5*age) - 161
            return bmr
        }
        
    }
    
    
    func tdeeCalc(weight:Double, height:Double, age:Double, gender: String, multiplyer:Double) -> Double {
        
//        1.2 = sedentary (little or no exercise)
//        1.375 = light activity (light exercise/sports 1 to 3 days per week)
//        1.55 = moderate activity (moderate exercise/sports 3 to 5 days per week)
//        1.725 = very active (hard exercise/sports 6 to 7 days per week)
//        1.9 = extra active (very hard exercise/sports 6 to 7 days per week and physical job)
        
        
        if gender == "Male" {
            let bmr = (10*weight) + (6.25*height) - (5*age) + 5
            let tdee = bmr*multiplyer
            return round((100*tdee))/100
        } else {
            let bmr = (10*weight) + (6.25*height) - (5*age) - 161
            let tdee = bmr*multiplyer
            return round((100*tdee))/100
        }
        
    }
    
    
}
