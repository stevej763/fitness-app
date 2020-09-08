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
        uiChanges()
        viewDefaults()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    
    
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let userWeightUnits =  weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
        let userHeightUnits = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
        
        //calculate bmi for different unit options
        switch userHeightUnits {
                case "Feet":
                    if (heightValue.text != "") && (ftValue.text != "") {
                        let heightInMeters = converter.ftToMeters(ftVlaue: Double(heightValue.text!)!, inchesValue: Double(ftValue.text!)!)
                        switch userWeightUnits {
                            //calculate bmi using feet and kg
                            case "Kg":
                                let bmi = calculator.bmiCalc(weight: Double(weightValue.text!)!, height: Double(heightInMeters))
                                self.view.endEditing(true)
                                calculator.bmi = String(bmi)
                                performSegue(withIdentifier: "goToResult", sender: self)
                            //calculate bmi using feet and Stone
                            case "Stone":
                                let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                                let bmi = calculator.bmiCalc(weight: weightInKg, height: heightInMeters)
                                self.view.endEditing(true)
                                calculator.bmi = String(bmi)
                                performSegue(withIdentifier: "goToResult", sender: self)
                            //calculate bmi using feet and lbs
                            case "Lbs":
                                let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                let bmi = calculator.bmiCalc(weight: weightInKg, height: heightInMeters)
                                self.view.endEditing(true)
                                calculator.bmi = String(bmi)
                                performSegue(withIdentifier: "goToResult", sender: self)
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
            let heightInMeters = Double(heightValue.text!)
            switch userWeightUnits {
                //calculate bmi using meters and kg
                case "Kg":
                    let bmi = calculator.bmiCalc(weight: Double(weightValue.text!)!, height: heightInMeters!)
                    self.view.endEditing(true)
                    calculator.bmi = String(bmi)
                    performSegue(withIdentifier: "goToResult", sender: self)
                //calculate bmi using meters and Stone
                case "Stone":
                    let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                    let bmi = calculator.bmiCalc(weight: weightInKg, height: heightInMeters!)
                    self.view.endEditing(true)
                    calculator.bmi = String(bmi)
                    performSegue(withIdentifier: "goToResult", sender: self)
                //calculate bmi using meters and lbs
                case "Lbs":
                    let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                    let bmi = calculator.bmiCalc(weight: weightInKg, height: heightInMeters!)
                    self.view.endEditing(true)
                    calculator.bmi = String(bmi)
                    performSegue(withIdentifier: "goToResult", sender: self)
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
            stoneValue.placeholder = "3"
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
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.results = calculator.bmi
        }
    }
    
    
    
    fileprivate func uiChanges() {
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(named: "blue1")
        calculate.layer.cornerRadius = 10
    }
    
    
    
    fileprivate func viewDefaults() {
        heightValue.placeholder = "e.g. 1.80"
        weightValue.placeholder = "e.g. 75.5"
        stoneValueLabel.isHidden = true
        stoneValue.isHidden = true
        feetValueLabel.isHidden = true
        ftValue.isHidden = true
        heightUnitsLabel.text = heightUnits.titleForSegment(at: heightUnits.selectedSegmentIndex)
        weightUnitsLabel.text = weightUnits.titleForSegment(at: weightUnits.selectedSegmentIndex)
    }
    
    
    
}

