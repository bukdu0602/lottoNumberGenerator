//
//  ViewController.swift
//  lottogenerator
//
//  Created by Ryan Lim on 2021-11-09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var choose: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var charIndex = 0.0
        let titleText = "Lottery Number Generator"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){ (timer) in self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }

   

}

