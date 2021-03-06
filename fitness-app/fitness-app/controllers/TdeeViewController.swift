//
//  TdeeViewController.swift
//  fitness-app
//
//  Created by Steve Jones on 05/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

class TdeeViewController: UIViewController {
   
    let converter = Converter()
    private var calculator = Calculator()
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleBackgroundView: UIView!
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap(view: self.view)
        viewDefaults()
        self.activityLevelPicker.dataSource = self
        self.activityLevelPicker.delegate = self

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
                                 if weightValue.text != "" {
                                calculator.tdeeCalc(weight: Double(weightValue.text!)!, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                performSegue(withIdentifier: "goToResult", sender: self)
                                 } else {
                                    Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                            }
                            //calculate bmi using feet and Stone
                            case "Stone":
                                if weightValue.text != "" && stoneValue.text != "" {
                                let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                                calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                performSegue(withIdentifier: "goToResult", sender: self)
                                } else {
                                    Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                            }
                            //calculate bmi using feet and lbs
                            case "Lbs":
                                 if weightValue.text != "" {
                                let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                performSegue(withIdentifier: "goToResult", sender: self)
                                 } else {
                                    Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                            }
                            default:
                                print("There was an error")
                                Alert.basicAlert(on: self, with: "Error", message: "There was an error")
                                
                        }
                    }
                    else {
                        Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
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
                                calculator.tdeeCalc(weight: Double(weightValue.text!)!, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                performSegue(withIdentifier: "goToResult", sender: self)
                                } else {
                                Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                            }
                            //calculate bmi using feet and Stone
                            case "Stone":
                                if weightValue.text != "" && stoneValue.text != "" {
                                let weightInKg = converter.convertToKg(valueToConvert: converter.stoneToLb(stoneValue: Double(weightValue.text!)!, lbValue: Double(stoneValue.text!)!))
                                calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
                                performSegue(withIdentifier: "goToResult", sender: self)
                                } else {
                                 Alert.basicAlert(on: self, with: "Blank box", message: "Make sure all boxes are filled")
                            }
                            //calculate bmi using feet and lbs
                            case "Lbs":
                                if weightValue.text != "" {
                                let weightInKg = converter.convertToKg(valueToConvert: Double(weightValue.text!)!)
                                calculator.tdeeCalc(weight: weightInKg, height: heightInCm, age: ageDouble!, gender: gender!, multiplyer: multiplyer)
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
            

        }
    }
    
    
  
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.results = calculator.result
        }
    }
    
    
    fileprivate func viewDefaults() {
        titleBackgroundView.layer.cornerRadius = 10
        calculateButton.layer.cornerRadius = 10
        activityLevelPicker.layer.cornerRadius = 10
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


//MARK:- picker methods
extension TdeeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
         }
         
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return K.activityOptions.count
         }
      
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return K.activityOptions[row]
      }
}
