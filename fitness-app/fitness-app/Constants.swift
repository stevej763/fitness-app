//
//  Constants.swift
//  fitness-app
//
//  Created by Steve Jones on 10/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit


struct K {
    
    static let activityOptions = ["Sedentry - no exercise", "Exercise 1-3 days a week", "Exercise 3-5 days a week", "Exercise 6-7 days a week", "Twice a day, every day"]
    
    struct Bmi {
        static let sender = "bmi"
        static let resultTitle = "BMI Result:"
        
        static let underweightColor = UIColor(named: "Underweight")
        static let normalColor = UIColor(named: "Normal")
        static let overweightColor = UIColor(named: "Overweight")
        static let obeseColor = UIColor(named: "Obese")
        
        struct Advice {
            static let obese = "You are in the Obese category, begin eating less and exercising more."
            static let overweight = "You are in the overweight category, try reducing the amount you eat and increasing your daily exercise."
            static let normal = "Great job, you are in the normal category for your weight and height."
            static let underweight = "Your BMI is too low, make sure you eat enough to maintain a healthy weight."
        }
        
    }
    
    struct Bmr {
        static let sender = "bmr"
        static let resultTitle = "BMR Estimate:"
        static let advice = "Your body needs this many calories each day to carry out it's basic functions."
        static let color = UIColor(named: "BmrColor")
        
    }
    
    struct Tdee {
        static let sender = "tdee"
        static let resultTitle = "TDEE Estimate:"
        static let color = UIColor(named: "TdeeColor")
        static let advice = "Based on your level of exercise, your body needs this many calories each day to maintain your current weight."
    }
    
    
    
    
    
    
}
