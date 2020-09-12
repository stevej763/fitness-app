//
//  keyboard.swift
//  fitness-app
//
//  Created by Steve Jones on 12/09/2020.
//  Copyright © 2020 95Design. All rights reserved.
//

import UIKit

func hideKeyboardOnTap(view: UIView ){
    let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
    view.addGestureRecognizer(tapGesture)
}
