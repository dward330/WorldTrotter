//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Derrick Ward on 12/11/16.
//  Copyright © 2016 Derrick Ward. All rights reserved.
//

import UIKit //Needed tp get UI Prefixed Classes

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    //Properties
    @IBOutlet var celsiusLabel: UILabel!; //Will be linked to the Celsius Label
    @IBOutlet var fahrenheitTextField: UITextField!; //Will be linked to the Fahrenheit TextField
    
    //This is a property with a property observer. A callback function is executed when certain things happen to the property
    var fahrenheitVal: Double?{
        didSet{
            UpdateCelsiusLabel(); //Update User Interface: Celsius Label Value
        }
    };
    
    //This is a computed property. Its value changes realtime, in relation to any variables it is dependent on.
    var celsiusVal: Double?{
        if let temp = fahrenheitVal{
            return ((temp - 32)*(5/9)); //Calculate the celsius value
        }
        else{
            return nil;
        }
    }
    
    //NumberFormatter
    var formatter : NumberFormatter {
        let x = NumberFormatter()
        x.numberStyle = NumberFormatter.Style.decimal;
        x.minimumFractionDigits = 0;
        x.maximumFractionDigits = 1;
        return x
    }

    //Event Handler for when the Fahrenheit TextField is changed
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField){
        if let temp = textField.text, let value = Double(temp){
            fahrenheitVal = value; //store the fahrenheit value
        }
        else{
            fahrenheitVal = nil;
        }
    }
    
    //Function to Update the Celsius Label
    func UpdateCelsiusLabel(){
        if let temp = celsiusVal{
            celsiusLabel.text = formatter.string(from: (NSNumber(value: temp)))
        }
        else{
            celsiusLabel.text = "???";
        }
    }
    
    //Event Handler for when the user clicks/taps/touches on the background view
    @IBAction func Handler_BackgroundViewClicked(sender: AnyObject){
        fahrenheitTextField.resignFirstResponder() //Take the First Responder focus off of this object, so that the keyboard disappers
    }
    
    //delegate method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text == "Tap to enter your value"){
            textField.text = "";
        }
    }
    
    //delegate method
    //Approves Changes made/entered by the user. Returning true means make the change and return false means dont return the change
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Current Text: \(textField.text)");
        print("Replacement Text: \(string)");
        
        let existingDecimalSeperator = textField.text?.range(of: ".");
        let replacementStringHasDecimalSeperator = string.range(of: ".");
        
        for charac in string.characters{
            if let temp = UnicodeScalar(String(charac)){
                if NSCharacterSet.letters.contains(temp){
                    return false;
                }
            }
        }
        
        if nil != existingDecimalSeperator && nil != replacementStringHasDecimalSeperator {
            return false; //Deny Change
        }
        else{
            return true; //Approve Change
        }
    }

    override func viewDidLoad() {
        //Always call the super implementation of viewDidLoad
        super.viewDidLoad();
        
        //My own implementation next
        print("ConversionViewController loaded its view.");
    }
    
}
