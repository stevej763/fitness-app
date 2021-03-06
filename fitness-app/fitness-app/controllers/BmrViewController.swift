//
//  BmrViewController.swift
//  fitness-app
//
//  Created by Steve Jones on 05/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

class BmrViewController: UIViewController {

    
    let converter = Converter()
    var calculator = Calculator()
    
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var genderValue: UISegmentedControl!
    @IBOutlet weak var ageValue: UITextField!
    @IBOutlet weak var heightUnitsSelector: UISegmentedControl!
    @IBOutlet weak var weightUnitsSelector: UISegmentedControl!
    @IBOutlet weak var heightUnitsLabel: UILabel!
    @IBOutlet weak var weightUnitsLabel: UILabel!
    @IBOutlet weak var ftValueLabel: UILabel!
    @IBOutlet weak var stoneValueLabel: UILabel!
    @IBOutlet weak var heightValue: UITextField!
    @IBOutlet weak var weightValue: UITextField!
    @IBOutlet weak var ftValue: UITextField!
    @IBOutlet weak var stoneValue: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDefaults()
        hideKeyboardOnTap(view: self.view)
    }
    

   
    
    //MARK:- changing units
    @IBAction func heightUnitsChanged(_ sender: Any) {
        if heightUnitsSelector.titleForSegment(at: heightUnitsSelector.selectedSegmentIndex) == "Feet" {
            heightValue.placeholder = "e.g. 6"
            heightValue.text = ""
            ftValue.isHidden = false
            ftValueLabel.isHidden = false
            ftValue.placeholder = "e.g. 1"
             heightUnitsLabel.text = "Inches"
        }
        else {
            heightValue.placeholder = "e.g. 1.80"
            heightValue.text = ""
            ftValue.isHidden = true
            ftValueLabel.isHidden = true
            heightUnitsLabel.text = heightUnitsSelector.titleForSegment(at: heightUnitsSelector.selectedSegmentIndex)
        }
    }
    
    @IBAction func weightUnitsChanged(_ sender: UISegmentedControl) {
        if weightUnitsSelector.titleForSegment(at: weightUnitsSelector.selectedSegmentIndex) == "Stone" {
            weightValue.placeholder = "e.g. 11"
            weightValue.text = ""
            stoneValueLabel.isHidden = false
            stoneValue.isHidden = false
            stoneValue.text = ""
            stoneValue.placeholder = "3"
            weightUnitsLabel.text = "Lbs"
        }
        else if weightUnitsSelector.titleForSegment(at: weightUnitsSelector.selectedSegmentIndex) == "Lbs" {
            weightValue.placeholder = "e.g. 180.2"
            weightValue.text = ""
            stoneValue.isHidden = true
            stoneValueLabel.isHidden = true
            weightUnitsLabel.text = weightUnitsSelector.titleForSegment(at: weightUnitsSelector.selectedSegmentIndex)
        }
        else {
            weightValue.placeholder = "e.g. 75.5"
            weightValue.text = ""
            stoneValue.isHidden = true
            stoneValueLabel.isHidden = true
            weightUnitsLabel.text = weightUnitsSelector.titleForSegment(at: weightUnitsSelector.selectedSegmentIndex)
        }
    }
    
    
    @IBAction func calculatePressed(_ sender: Any) {
        let userWeightUnits =  weightUnitsSelector.titleForSegment(at: weightUnitsSelector.selectedSegmentIndex)
        let userHeightUnits = heightUnitsSelector.titleForSegment(at: heightUnitsSelector.selectedSegmentIndex)
        let gender = genderValue.titleForSegment(at: genderValue.selectedSegmentIndex)
        let ageDouble = Double(ageValue.text!)
        
        switch userHeightUnits {
                    case "Feet":
                        if (heightValue.text != "") && (ftValue.text != "") {
                            let heightInCm = 100*(converter.ftToMeters(ftVlaue: Double(heightValue.text!)!, inchesValue: Double(ftValue.text!)!))
                            switch userWeightUnits {
                                //calculate bmi using feet and kg
                                case "Kg":
                                    if weightValue.text != "" {
                                    calculator.bmrCalc(weight: Double(weightValue.text!)!, height: heightInCm, age: ageDouble!, gender: gender!)
                                    performSegue(withIdentifier: "goToResult", sender: self)
                                }
                                    else {
                                    Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                                }
                                //calculate bmi using feet and Stone
                                case "Stone":
                                   if weightValue.text != "" && stoneValue.text != "" {
                                    let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                                    calculator.bmrCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!)
                                    performSegue(withIdentifier: "goToResult", sender: self)
                                   } else {
                                    Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                                }
                                
                                //calculate bmi using feet and lbs
                                case "Lbs":
                                    if weightValue.text != "" {
                                    let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                    calculator.bmrCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!)
                                    performSegue(withIdentifier: "goToResult", sender: self)
                                }
                                    else {
                                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                                                                   
                                }
                                default:
                                    print("There was an error")
                                    
                            }
                        }
                        else {
                            //add error alert  box here
                            print("blank box")
                }
            
            //Default is meters
            default:
                if (heightValue.text != "") {
                    //convert to cm for calculation
                let heightInCm = 100 * Double(heightValue.text!)!
                            switch userWeightUnits {
                                //calculate bmi using feet and kg
                                case "Kg":
                                    if weightValue.text != "" {
                                    calculator.bmrCalc(weight: Double(weightValue.text!)!, height: heightInCm, age: ageDouble!, gender: gender!)
                                    performSegue(withIdentifier: "goToResult", sender: self)
                                }
                                    else {
                                       Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                                }
                            //calculate bmi using feet and Stone
                                case "Stone":
                                    if weightValue.text != "" && stoneValue.text != "" {
                                    let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                                    calculator.bmrCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!)
                                    performSegue(withIdentifier: "goToResult", sender: self)
                                }
                                    else {
                                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                                                        
                                }
                                //calculate bmi using feet and lbs
                                case "Lbs":
                                    if weightValue.text != "" {
                                    let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                    calculator.bmrCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!)
                                    performSegue(withIdentifier: "goToResult", sender: self)
                                    } else {
                                         Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                                }
                                default:
                                     Alert.basicAlert(on: self, with: "Error", message: "There was an error with the values given")
                                    
                            }
                        }
                        else {
                            //add error alert  box here
                            Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                }
                

            }
        
        }//end of calculateButtonPressed
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.results = calculator.result
        }
    }
    
    
    
    fileprivate func viewDefaults() {
        
        self.view.backgroundColor = UIColor(named: "blue2")
        calculateButton.layer.cornerRadius = 10
        titleBackgroundView.layer.cornerRadius = 10
        heightValue.placeholder = "e.g. 1.80"
        weightValue.placeholder = "e.g. 75.5"
        stoneValueLabel.isHidden = true
        stoneValue.isHidden = true
        ftValueLabel.isHidden = true
        ftValue.isHidden = true
        heightUnitsLabel.text = heightUnitsSelector.titleForSegment(at: heightUnitsSelector.selectedSegmentIndex)
        weightUnitsLabel.text = weightUnitsSelector.titleForSegment(at: weightUnitsSelector.selectedSegmentIndex)
    }
    
    
    
    
    
}
