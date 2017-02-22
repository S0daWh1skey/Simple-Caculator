//
//  ViewController.swift
//  简易计算器
//
//  Created by Albert Sphepherd on 2017/2/21.
//  Copyright © 2017年 Albert Sphepherd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var operations = " "
    
    var opperandStack = Array<Double>()
    
    var historyStack = Array<Double>()
    
    
    var userIsInTheMiddleOfTypingNumber = false
    
    @IBOutlet weak var dispaly: UILabel!
    
    @IBOutlet weak var displayResult: UILabel!
    
    @IBAction func Number(sender: UIButton) {
        let number = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber{
            dispaly.text = dispaly.text! + number
            opperandStack.removeLast()
            opperandStack.append(displayValue)
        }
        else{
            dispaly.text = " "
            dispaly.text = number
            userIsInTheMiddleOfTypingNumber = true
            opperandStack.append(displayValue)
        }
        print("number = \(number)")
    }     //输入数字并显示在输入框
    
    
    @IBAction func operate(sender: UIButton) {
         let operation = sender.currentTitle!
             operations = operation
        if userIsInTheMiddleOfTypingNumber{
            userIsInTheMiddleOfTypingNumber = false      //终止用户输入
            //opperandStack.append(displayValue)           //将终止前的数据压入栈
            print("opperandStack = \(opperandStack)")
            dispaly.text = " "
            dispaly.text = dispaly.text! + operation     //显示符号
            //userIsInTheMiddleOfTypingNumber = true       //继续用户输入
            
        }
        else {
            dispaly.text = "Error"
        }
    }
    
    
    @IBAction func equal() {
        historyStack.append(opperandStack[0])
        historyStack.append(opperandStack[1])
        switch  operations{
            case "×":
                performOperation(operation: {$0 * $1})
        case "÷":
                performOperation(operation: {$1 / $0})
        case "+":
                performOperation(operation: {$0 + $1})
        case "-":
                performOperation(operation: {$1 - $0})
        default: break
        }
        
    }
    
    
    func performOperation(operation: (Double, Double) -> Double){
        if(opperandStack.count == 2){
           let displayValueResult = operation(opperandStack.removeLast(),opperandStack.removeLast())
            let strVar : String = String(displayValueResult)
            displayResult.text = strVar
            opperandStack.removeAll()
            opperandStack.append(displayValueResult)
        }
    }
    
    @IBAction func history() {
        
        displayValue = historyStack.popLast()!
    }
    
    @IBAction func clera() {
        dispaly.text = "0"
        opperandStack.removeAll()
        historyStack.removeAll()
        displayResult.text = "这里是答案"
        userIsInTheMiddleOfTypingNumber = false
    }
    var displayValue: Double{
        get{
            return NumberFormatter().number(from:dispaly.text!)as! Double
        }
        set{
            dispaly.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
    
}

