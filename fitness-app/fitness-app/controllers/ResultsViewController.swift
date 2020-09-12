//
//  ResultsViewController.swift
//  fitness-app
//
//  Created by Steve Jones on 06/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var senderTitleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    
    var results: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recalculateButton.layer.cornerRadius = 10
        
        
        if results?.sender == K.Bmi.sender {
            senderTitleLabel.text = K.Bmi.resultTitle
        } else if results?.sender == K.Bmr.sender {
            senderTitleLabel.text = K.Bmr.resultTitle
        } else if results?.sender == K.Tdee.sender {
            senderTitleLabel.text = K.Tdee.resultTitle
        }
        
        
        
        resultLabel.text = results?.value
        resultLabel.textColor = results?.colour
        adviceLabel.text = results?.advice
        

    }

    @IBAction func recalculatePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tabPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
