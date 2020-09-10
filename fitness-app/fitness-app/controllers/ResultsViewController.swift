//
//  ResultsViewController.swift
//  fitness-app
//
//  Created by Steve Jones on 06/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultsBackgroundView: UIView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var results: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = results?.value
        senderLabel.text = results?.sender
        adviceLabel.text = results?.advice
        
        resultsBackgroundView.layer.backgroundColor = results?.colour.cgColor
        
        resultsBackgroundView.layer.borderWidth = 5
        resultsBackgroundView.layer.borderColor = UIColor(named: "text-input")?.cgColor
        resultsBackgroundView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
