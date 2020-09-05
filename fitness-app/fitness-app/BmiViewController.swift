//
//  ViewController.swift
//  fitness-app
//
//  Created by Steve Jones on 16/08/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

class BmiViewController: UIViewController {

    let converter = Converter()
    
    @IBOutlet weak var bmiView: UIView!
    @IBOutlet weak var bmiResultLabel: UILabel!
    @IBOutlet weak var heightUnits: UISegmentedControl!
    @IBOutlet weak var weightUnits: UISegmentedControl!
    @IBOutlet weak var heightValue: UITextField!
    @IBOutlet weak var weightValue: UITextField!
    @IBOutlet weak var heightUnitsLabel: UILabel!
    @IBOutlet weak var weightUnitsLabel: UILabel!
    @IBOutlet weak var extraBoxForStoneAndPounds: UITextField!
    @IBOutlet weak var extraBoxForFeetAndInches: UITextField!
    @IBOutlet weak var extraLabelForStone: UILabel!
    @IBOutlet weak var extraLabelForFeet: UILabel!
    @IBOutlet weak var calcuateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bmiView.backgroundColor = UIColor(named: "blue3")
        bmiView.layer.cornerRadius = 10
        
        heightValue.placeholder = "1.80"
        weightValue.placeholder = "75"
        
        
        
        
        
        extraLabelForStone.isHidden = true
        extraBoxForStoneAndPounds.isHidden = true
        extraLabelForFeet.isHidden = true
        extraBoxForFeetAndInches.isHidden = true
        bmiResultLabel.isHidden = true
        
        calcuateButton.layer.cornerRadius = 10
        heightUnitsLabel.text = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
         weightUnitsLabel.text = weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
    }
    

    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        //bmi = kg/h x h
        let userWeightUnits =  weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
        let userHeightUnits = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
        
        //calculate bmi for different unit options
        
        
        switch userHeightUnits {
                case "Feet":
                    if (heightValue.text != "") && (extraBoxForFeetAndInches.text != "") {
                        let heightInMeters = converter.ftToMeters(ftVlaue: Double(heightValue.text!)!, inchesValue: Double(extraBoxForFeetAndInches.text!)!)
                        switch userWeightUnits {
                            //calculate bmi using feet and kg
                            case "Kg":
                                let bmi = converter.bmiCalc(weight: Double(weightValue.text!)!, height: Double(heightInMeters))
                                bmiResultLabel.isHidden = false
                                bmiResultLabel.text = "Your BMI is: \(bmi)"
                                self.view.endEditing(true)
                            //calculate bmi using feet and Stone
                            case "Stone":
                                let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(extraBoxForStoneAndPounds.text!)!))
                                let bmi = converter.bmiCalc(weight: weightInKg, height: heightInMeters)
                                bmiResultLabel.isHidden = false
                                bmiResultLabel.text = "Your BMI is: \(bmi)"
                                self.view.endEditing(true)
                            //calculate bmi using feet and lbs
                            case "Lbs":
                                let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                let bmi = converter.bmiCalc(weight: weightInKg, height: heightInMeters)
                                bmiResultLabel.isHidden = false
                                bmiResultLabel.text = "Your BMI is: \(bmi)"
                                self.view.endEditing(true)
                            default:
                                print("There was an error")
                                
                        }
                    }
                    else {
                        //add error alert  box here
                        print("blank box")
            }
                //take the mesurement in ft and convert to meters
                
                
                
        //Default is meters
        default:
            if (heightValue.text != "") {
            let heightInMeters = Double(heightValue.text!)
            switch userWeightUnits {
                //calculate bmi using meters and kg
                case "Kg":
                    let bmi = converter.bmiCalc(weight: Double(weightValue.text!)!, height: heightInMeters!)
                    bmiResultLabel.isHidden = false
                    bmiResultLabel.text = "Your BMI is: \(bmi)"
                    self.view.endEditing(true)
                //calculate bmi using meters and Stone
                case "Stone":
                    let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(extraBoxForStoneAndPounds.text!)!))
                    let bmi = converter.bmiCalc(weight: weightInKg, height: heightInMeters!)
                    bmiResultLabel.isHidden = false
                    bmiResultLabel.text = "Your BMI is: \(bmi)"
                 self.view.endEditing(true)
                //calculate bmi using meters and lbs
                case "Lbs":
                    let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                    let bmi = converter.bmiCalc(weight: weightInKg, height: heightInMeters!)
                    bmiResultLabel.isHidden = false
                    bmiResultLabel.text = "Your BMI is: \(bmi)"
                    self.view.endEditing(true)
                default:
                    print("There was an error")
            }
            }
            else {
                //add error alert  box here
                print("blank box")
            }
            

        }
    
    }//end of calculateButtonPressed
    
    
//MARK:- changing units
    @IBAction func heightUnitsChanged(_ sender: Any) {
        if heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex) == "Feet" {
            heightValue.placeholder = "6"
            heightValue.text = ""
            extraBoxForFeetAndInches.isHidden = false
            extraLabelForFeet.isHidden = false
            extraBoxForFeetAndInches.placeholder = "1"
             heightUnitsLabel.text = "Inches"
        }
        else {
            heightValue.placeholder = "1.80"
            heightValue.text = ""
            extraBoxForFeetAndInches.isHidden = true
            extraLabelForFeet.isHidden = true
            heightUnitsLabel.text = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
        }
    }
    
    @IBAction func weightUnitsChanged(_ sender: UISegmentedControl) {
        if weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex) == "Stone" {
            weightValue.placeholder = "11"
            weightValue.text = ""
            extraLabelForStone.isHidden = false
            extraBoxForStoneAndPounds.isHidden = false
            extraBoxForStoneAndPounds.placeholder = "3"
            weightUnitsLabel.text = "Lbs"
        }
        else if weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex) == "Lbs" {
            weightValue.placeholder = "180"
            weightValue.text = ""
            extraBoxForStoneAndPounds.isHidden = true
            extraLabelForStone.isHidden = true
            weightUnitsLabel.text = weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
        }
        else {
            weightValue.placeholder = "75"
            weightValue.text = ""
            extraBoxForStoneAndPounds.isHidden = true
            extraLabelForStone.isHidden = true
            weightUnitsLabel.text = weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
        }
    }
}

