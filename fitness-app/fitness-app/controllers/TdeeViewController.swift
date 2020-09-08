//
//  TdeeViewController.swift
//  fitness-app
//
//  Created by Steve Jones on 05/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

class TdeeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    let converter = Converter()
    var calculator = Calculator()
    
    
    
    @IBOutlet weak var genderValue: UISegmentedControl!
    @IBOutlet weak var ageValue: UITextField!
    @IBOutlet weak var heightUnitsSelector: UISegmentedControl!
    @IBOutlet weak var heightUnitsLabel: UILabel!
    @IBOutlet weak var heightValue: UITextField!
    @IBOutlet weak var ftValue: UITextField!
    @IBOutlet weak var ftValueLabel: UILabel!
    
    @IBOutlet weak var weightUnitsSelector: UISegmentedControl!
    @IBOutlet weak var weightUnitsLabel: UILabel!
    @IBOutlet weak var weightValue: UITextField!
    @IBOutlet weak var stoneValue: UITextField!
    @IBOutlet weak var stoneValueLabel: UILabel!
    
    
    @IBOutlet weak var activityLevelPicker: UIPickerView!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    let activityOptions = ["Sedentry - no exercise", "Exercise 1-3 days a week", "Exercise 3-5 days a week", "Exercise 6-7 days a week", "Twice a day, every day"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateButton.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
       
        self.activityLevelPicker.dataSource = self
        self.activityLevelPicker.delegate = self
        
        viewDefaults()
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
        let pickerRow = activityLevelPicker.selectedRow(inComponent: 0)
        var multiplyer = 1.0
        switch pickerRow {
        case 0:
            multiplyer = 1.2
            case 1:
            multiplyer = 1.375
            case 2:
            multiplyer = 1.55
            case 3:
            multiplyer = 1.725
            case 4:
            multiplyer = 1.9
        default:
            multiplyer = 1.2
        }
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
                                let tdee = calculator.tdeeCalc(weight: Double(weightValue.text!)!, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                self.view.endEditing(true)
                                calculator.tdee = String(tdee)
                                performSegue(withIdentifier: "goToResult", sender: self)
                            //calculate bmi using feet and Stone
                            case "Stone":
                                if stoneValue.text == "" {
                                    stoneValue.text = "0"
                                }
                                let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                                let tdee = calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                self.view.endEditing(true)
                                calculator.tdee = String(tdee)
                                performSegue(withIdentifier: "goToResult", sender: self)
                            //calculate bmi using feet and lbs
                            case "Lbs":
                                let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                let tdee = calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                self.view.endEditing(true)
                                calculator.tdee = String(tdee)
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
                //convert to cm for calculation
            let heightInCm = 100 * Double(heightValue.text!)!
                        switch userWeightUnits {
                            //calculate bmi using feet and kg
                            case "Kg":
                                let tdee = calculator.tdeeCalc(weight: Double(weightValue.text!)!, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                self.view.endEditing(true)
                                calculator.tdee = String(tdee)
                                performSegue(withIdentifier: "goToResult", sender: self)
                            //calculate bmi using feet and Stone
                            case "Stone":
                                if stoneValue.text == "" {
                                    stoneValue.text = "0"
                                }
                                let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                                let tdee = calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                self.view.endEditing(true)
                                calculator.tdee = String(tdee)
                                performSegue(withIdentifier: "goToResult", sender: self)
                            //calculate bmi using feet and lbs
                            case "Lbs":
                                let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                let tdee = calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                self.view.endEditing(true)
                                calculator.tdee = String(tdee)
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
    }
    
    
    //MARK:- picker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityOptions.count
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityOptions[row]
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.results = calculator.tdee
        }
    }
    
    
    fileprivate func viewDefaults() {
        self.view.backgroundColor = UIColor(named: "blue3")
        activityLevelPicker.selectRow(1, inComponent: 0, animated: true)
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
