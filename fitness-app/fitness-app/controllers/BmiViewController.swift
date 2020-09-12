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
    var calculator = Calculator()
    
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var heightUnits: UISegmentedControl!
    @IBOutlet weak var weightUnits: UISegmentedControl!
    @IBOutlet weak var heightValue: UITextField!
    @IBOutlet weak var weightValue: UITextField!
    @IBOutlet weak var heightUnitsLabel: UILabel!
    @IBOutlet weak var weightUnitsLabel: UILabel!
    @IBOutlet weak var stoneValue: UITextField!
    @IBOutlet weak var ftValue: UITextField!
    @IBOutlet weak var stoneValueLabel: UILabel!
    @IBOutlet weak var feetValueLabel: UILabel!
    @IBOutlet weak var calculate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDefaults()
        hideKeyboardOnTap(view: self.view)
    }
    
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        getBmi()
    }
    
    
//MARK:- changing units
    @IBAction func heightUnitsChanged(_ sender: Any) {
        if heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex) == "Feet" {
            heightValue.placeholder = "e.g. 6"
            heightValue.text = ""
            ftValue.isHidden = false
            feetValueLabel.isHidden = false
            ftValue.placeholder = "e.g. 1"
             heightUnitsLabel.text = "Inches"
        }
        else {
            heightValue.placeholder = "e.g. 1.80"
            heightValue.text = ""
            ftValue.isHidden = true
            feetValueLabel.isHidden = true
            heightUnitsLabel.text = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
        }
    }
    @IBAction func weightUnitsChanged(_ sender: UISegmentedControl) {
        if weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex) == "Stone" {
            weightValue.placeholder = "e.g. 11"
            weightValue.text = ""
            stoneValueLabel.isHidden = false
            stoneValue.isHidden = false
            stoneValue.text = ""
            stoneValue.placeholder = "eg. 3"
            weightUnitsLabel.text = "Lbs"
        }
        else if weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex) == "Lbs" {
            weightValue.placeholder = "e.g. 180.2"
            weightValue.text = ""
            stoneValue.isHidden = true
            stoneValueLabel.isHidden = true
            weightUnitsLabel.text = weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
        }
        else {
            weightValue.placeholder = "e.g. 75.5"
            weightValue.text = ""
            stoneValue.isHidden = true
            stoneValueLabel.isHidden = true
            weightUnitsLabel.text = weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
        }
    }
    
    //MARK:- units switch
    fileprivate func getBmi(){
        
        let userWeightUnits =  weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
        let userHeightUnits = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
        
        switch userHeightUnits {
        case "Feet":
            if (heightValue.text != "") && (ftValue.text != "") {
                let heightInMeters = converter.ftToMeters(ftVlaue: Double(heightValue.text!)!, inchesValue: Double(ftValue.text!)!)
                switch userWeightUnits {
                    case "Kg":
                        if weightValue.text != "" {
                            calculator.bmiCalc(weight: Double(weightValue.text!)!, height: Double(heightInMeters))
                            performSegue(withIdentifier: "goToResult", sender: self)
                    } else {
                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                    }
                    case "Stone":
                        if weightValue.text != "" && stoneValue.text != "" {
                            let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                            calculator.bmiCalc(weight: weightInKg, height: heightInMeters)
                            performSegue(withIdentifier: "goToResult", sender: self)
                        
                    } else {
                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                    }
                    case "Lbs":
                        if weightValue.text != "" {
                            let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                            calculator.bmiCalc(weight: weightInKg, height: heightInMeters)
                            performSegue(withIdentifier: "goToResult", sender: self)
                    } else {
                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                    }
                    default:
                        Alert.basicAlert(on: self, with: "Error", message: "There was an error with the values given")
                }
            }
            else {
                Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
            }
        //Default is meters
        default:
            if (heightValue.text != "") {
                let heightInMeters = Double(heightValue.text!)
                switch userWeightUnits {
                //calculate bmi using meters and kg
                case "Kg":
                    if weightValue.text != "" {
                          calculator.bmiCalc(weight: Double(weightValue.text!)!, height: heightInMeters!)
                          performSegue(withIdentifier: "goToResult", sender: self)
                    } else {
                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                    }
                    
                //calculate bmi using meters and Stone
                case "Stone":
                    if weightValue.text != "" && stoneValue.text != "" {
                        let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                        calculator.bmiCalc(weight: weightInKg, height: heightInMeters!)
                        performSegue(withIdentifier: "goToResult", sender: self)
                    } else {
                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                    }
                    
                //calculate bmi using meters and lbs
                case "Lbs":
                    if weightValue.text != "" {
                        let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                        calculator.bmiCalc(weight: weightInKg, height: heightInMeters!)
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
    }
    
    
    
    //pass result to result view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.results = calculator.result
        }
    }
    
    
    //MARK:- viewDidLoad methods
    fileprivate func viewDefaults() {
        self.view.backgroundColor = UIColor(named: "blue1")
        calculate.layer.cornerRadius = 10
        titleBackgroundView.layer.cornerRadius = 10
        heightValue.placeholder = "e.g. 1.80"
        weightValue.placeholder = "e.g. 75.5"
        stoneValueLabel.isHidden = true
        stoneValue.isHidden = true
        feetValueLabel.isHidden = true
        ftValue.isHidden = true
        heightUnitsLabel.text = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
        weightUnitsLabel.text = weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
    }
    
//    fileprivate func hideKeyboardOnTap() {
//        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//        view.addGestureRecognizer(tapGesture)
//    }
    
    
}

