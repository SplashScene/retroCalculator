//
//  ViewController.swift
//  retroCalculator
//
//  Created by Kevin Farm on 3/13/16.
//  Copyright © 2016 splashscene. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var lblCalcDisplay: UILabel!
    var tempNumber = ""
    var firstNumber:Int = 0
    var secondNumber:Int = 0
    var mathOperation: String = ""
    var totalNumber:Double = 0.00
    
    var buttonSound = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do{
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func btnNumberTapped(sender: UIButton) {
        playSound()
        if totalNumber > 0 { resetCalc() }
        printDisplay(String(sender.tag))
        tempNumber += String(sender.tag)
    }
    
    func printDisplay(num: String){
        if lblCalcDisplay.text == "Error"{
            lblCalcDisplay.text = ""
            var text = lblCalcDisplay.text!
            text += num
            lblCalcDisplay.textColor = UIColor.blackColor()
            lblCalcDisplay.text = text
        }else{
            var text = lblCalcDisplay.text!
            text += num
            lblCalcDisplay.text = text
        }
    }

    @IBAction func btnMathOperation(sender: UIButton) {
        playSound()
        if tempNumber.characters.count > 0{
            firstNumber = Int(tempNumber)!
            tempNumber = ""
            determineMathOperation(sender.tag)
        }else{
            lblCalcDisplay.textColor = UIColor.redColor()
            lblCalcDisplay.text = "Error"
        }
    }

    @IBAction func btnEquals(sender: UIButton) {
        playSound()
        if tempNumber.characters.count > 0{
            secondNumber = Int(tempNumber)!
            let myTotal = getTotal()
            lblCalcDisplay.text = String(myTotal)
        }else{
            lblCalcDisplay.textColor = UIColor.redColor()
            lblCalcDisplay.text = "Error"
        }
    }
    
    func determineMathOperation(math: Int){
        switch(math){
            case 10: mathOperation = "divide"
                     printDisplay(" / ")
            case 11: mathOperation = "multiply"
                     printDisplay(" X ")
            case 12: mathOperation = "subtract"
                     printDisplay(" - ")
            default: mathOperation = "addition"
                     printDisplay(" + ")
        }
    }
    
    func getTotal() -> Double{
        switch(mathOperation){
            case "divide": totalNumber = Double(firstNumber) / Double(secondNumber)
            case "multiply": totalNumber = Double(firstNumber) * Double(secondNumber)
            case "subtract": totalNumber = Double(firstNumber) - Double(secondNumber)
            default: totalNumber = Double(firstNumber) + Double(secondNumber)
        }
        return totalNumber
    }
    
    func resetCalc(){
        tempNumber = ""
        firstNumber = 0
        secondNumber = 0
        mathOperation = ""
        totalNumber = 0
        lblCalcDisplay.text = ""
    }
    
    func playSound(){
        if buttonSound.playing { buttonSound.stop() }
        buttonSound.play()
    }
}

