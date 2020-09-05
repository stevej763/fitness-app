//
//  bmiCalculator.swift
//  fitness-app
//
//  Created by Steve Jones on 16/08/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import Foundation


struct Converter {

//convert stone or lb to Kg
func convertToKg(valueToConvert value: Double) -> Double {
        let result = Double(value * 0.45359)
        return(round(100*result)/100)
}
func stoneToLb(stoneValue stone:Double, lbValue lb:Double) -> Double {
    let totalLb = (stone*14) + lb
    return totalLb
}

//convert ft and inches to Meters
func inchesToMeters(valueToConvert value: Double) -> Double {
    return Double(round(100*(value * 0.0254 ))/100)
}
func ftToMeters(ftVlaue feet:Double, inchesValue inches:Double) -> Double {
    let totalInch = (feet*12) + inches
    let result = inchesToMeters(valueToConvert: totalInch)
    return result
}
    
    
    
func bmiCalc(weight:Double, height:Double) -> Double {
    let bmi = weight / (height*height)
    return round((100*bmi))/100
    }
    
    
    
}
