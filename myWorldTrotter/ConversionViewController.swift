//
//  ViewController.swift
//  myWorldTrotter
//
//  Created by Michael Worden on 1/3/22.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }

    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }

    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        //updateCelsiusLabel()

        
        //let firstFrame=CGRect(x: 160, y: 240, width: 100, height: 150)
        //let firstView = UIView(frame: firstFrame)
        //firstView.backgroundColor = UIColor.blue
        
        /*let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor,
                                UIColor.blue.cgColor,
                                UIColor.green.cgColor,
                                UIColor.yellow.cgColor,
                                UIColor.red.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)*/
       // view.addSubview(firstView)
        

        
   }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
                fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
            } else {
                fahrenheitValue = nil
            }

    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text =
                        numberFormatter.string(from: NSNumber(value: celsiusValue.value))

            } else {
                celsiusLabel.text = "???"
            }


    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {


        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."

        let existingTextHasDecimalSeparator
                = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)

        if (existingTextHasDecimalSeparator != nil &&
            replacementTextHasDecimalSeparator != nil)
           {
                return false
            } else {
                return true
            }

        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let myColors = [ UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple]
        let index = Int.random(in: 0..<6)
        view.backgroundColor = myColors[index]
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }

     

}

