//
//  ViewController.swift
//  simple_calculator
//
//  Created by David Utt on 3/16/17.
//  Copyright © 2017 David Utt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultsLable: UILabel!
    
    var firstNumberText = ""
    var secondNumberText = ""
    var op = ""
    var firstNumber = true
    var hasOp = false
    var canClear = true
    
    
    @IBAction func handleButtonPress(_ sender: UIButton) {

        if canClear {
            resultsLable.text = ""
            resultsLable.text = "0"
            canClear = false
        }
        
        let currentText = resultsLable.text!
        let textLabel = sender.titleLabel?.text
        
        if let text = textLabel {
            switch text {
            case "+", "*", "/", "-":
                if hasOp {
                    return
                }
                op = text
                firstNumber = false
                hasOp = true
                resultsLable.text = "\(currentText) \(op) "
                break
            case "=":
                firstNumber = true
                hasOp = false
                canClear = true
                let result = calculate()
                resultsLable.text = "\(result)"
                break
            default:
                if firstNumber {
                    firstNumberText = "\(firstNumberText)\(text)"
                } else {
                    secondNumberText = "\(secondNumberText)\(text)"
                }
                resultsLable.text = "\(currentText)\(text)"
                break;
            }
        }
    }
    
    func calculate() -> Double{
        //bug becuase it is always looking for a second number when calculating as a non operational value
        let firstNumber = Double(firstNumberText)!
        let secondNumber = Double(secondNumberText)!
        firstNumberText = ""
        secondNumberText = ""
        switch op {
        case "+":
            return firstNumber + secondNumber
        case "-":
            return firstNumber - secondNumber
        case "*":
            return firstNumber * secondNumber
        case "/":
            return firstNumber / secondNumber
        default:
            return 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveAction(_ sender: UIButton) {
        UIPasteboard.general.string = "\(resultsLable)"
    }

}

