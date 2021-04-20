//
//  ViewController.swift
//  Calculator
//
//  Created by Владислав on 16.04.2021.
//

import UIKit

class NewViewController: UIViewController {
    
    var numberFromScreen : Double = 0
    var firstNumber : Double = 0
    var actionMade : Bool = false
    var swappedColor : Bool = false
    var operation = 0
    var afterEqual : Bool = false
    var digitscount = 0
    //

    func noZero(num : Double)->String{
        if Double(Int(num)) == num{
            return String(Int(num))
        }
        else{
            return String(round(100000000*num)/100000000)
        }
    }
    //
    
    func swapColorsForTag(tagNum : Int){
        let tagButton = self.view.viewWithTag(tagNum) as? UIButton
        swapColors(tagButton!)
    }
   //
    
    func swapColors(_ sender: UIButton){
        let backColor = sender.backgroundColor
        sender.backgroundColor = sender.currentTitleColor
        sender.setTitleColor(backColor, for: .normal)
        sender.layer.borderColor = backColor?.cgColor
        swappedColor = true
    }
    //
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var answer: UILabel!
    
    @IBOutlet var digits: [UIButton]!
    //
    
    @IBAction func digitsPressed(_ sender: UIButton) {
        if answer.text!.count < 10{
            
        clearButton.setTitle("C", for: .normal)
        var digit = sender.currentTitle!
        
        if sender.tag == 1 && Double(answer.text!) == nil{
            digit = "0."
        }
        
        if sender.tag == 1 && ((answer.text!.contains(".")) == true){
            digit = ""
        }
            
        if actionMade == true && operation != 0{
            swapColorsForTag(tagNum: operation)
            swappedColor = false
            answer.text = digit
            actionMade = false
        }
        
        else if (actionMade == true && operation == 0) || (answer.text == "0" && sender.tag != 1) || (afterEqual == true && actionMade == true){
            if afterEqual == true{
                afterEqual = false
            }
            answer.text = digit
            actionMade = false
        }
        
        else{
            answer.text! += digit
        }
        
        if let answertext = Double(answer.text!){
            numberFromScreen = answertext
        }
        }
    }
    //
    
    @IBAction func actions(_ sender: UIButton) {
        
        if answer.text != "" && sender.tag != 9 && sender.tag != 14 && sender.tag != 8 && sender.tag != 7{
            if Double(answer.text!) != nil{
                firstNumber = Double(answer.text!)!
            }
            else{
                if operation != sender.tag{
                    swapColorsForTag(tagNum: operation)
                    swapColors(sender)
                }
                operation = sender.tag
            }
            actionMade = true
            if sender.currentTitle == "/"{
                if swappedColor == false{
                    swapColors(sender)
                }
                else if swappedColor == true && operation != sender.tag{
                    swapColorsForTag(tagNum: operation)
                    swapColors(sender)
                }
                answer.text = "/"
            }
            if sender.currentTitle == "x"{
                if swappedColor == false{
                    swapColors(sender)
                }
                else if swappedColor == true && operation != sender.tag{
                    swapColorsForTag(tagNum: operation)
                    swapColors(sender)
                }
                    answer.text = "x"
            }
            if sender.currentTitle == "-"{
                if swappedColor == false{
                    swapColors(sender)
                }
                else if swappedColor == true && operation != sender.tag{
                    swapColorsForTag(tagNum: operation)
                    swapColors(sender)
                }
                answer.text = "-"
            }
            if sender.currentTitle == "+"{
                if swappedColor == false{
                    swapColors(sender)
                }
                else if swappedColor == true && operation != sender.tag{
                    swapColorsForTag(tagNum: operation)
                    swapColors(sender)
                }
                answer.text = "+"
                
            }
            
            operation = sender.tag
            actionMade = true
        }

        else if sender.tag == 7{
            if !answer.text!.isEmpty{
                if Double(answer.text!) != nil{
                answer.text!.removeLast()
                }
            }
            if let answertext = Double(answer.text!){
                numberFromScreen = answertext
            }
        }
        
        else if sender.tag == 14{
            if actionMade == false{
                
            if operation == 10{
                if numberFromScreen == 0{
                    answer.text = "Inf"
                }
                else{
                    answer.text = noZero(num: firstNumber / numberFromScreen)
                }
            }
            if operation == 11{
                answer.text = noZero(num: firstNumber * numberFromScreen)
            }
            if operation == 12{
                answer.text = noZero(num: firstNumber - numberFromScreen)
            }
            if operation == 13{
                answer.text = noZero(num: firstNumber + numberFromScreen)
            }
            afterEqual = true
            }
        }

        else if sender.tag == 8{
            
            if operation == 12 || operation == 13{
                answer.text = noZero(num: firstNumber*numberFromScreen/100)
                numberFromScreen = firstNumber*numberFromScreen/100
            }
            
            else{
                if var procent = Double(answer.text!){
                procent = procent/100
                numberFromScreen = procent
                answer.text = String(procent)
                }
            }
        }
        else if sender.tag == 9 {
            if swappedColor == true{
                swapColorsForTag(tagNum: operation)
                swappedColor = false
            }
            clearButton.setTitle("AC", for: .normal)
            actionMade = false
            answer.text = "0"
            firstNumber = 0
            numberFromScreen = 0
            operation = 0
        }
        
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answer.text = "0"
        answer.numberOfLines = 1
        answer.adjustsFontSizeToFitWidth = true
        // round buttons begin
        digits.forEach{
            $0.layer.cornerRadius = $0.frame.size.height / 3
            $0.layer.borderWidth = 3
            $0.layer.borderColor = UIColor.white.cgColor
        }
        // round buttons end
        
        
    }
}

