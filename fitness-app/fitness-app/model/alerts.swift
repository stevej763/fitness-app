//
//  alerts.swift
//  fitness-app
//
//  Created by Steve Jones on 08/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

struct Alert {
    
    static func basicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    
    
    
}


