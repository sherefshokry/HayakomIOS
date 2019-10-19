//
//  Validations.swift
//  MyLexus
//
//  Created by Nora on 6/19/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation

class Validations {
    
    static func isValidPhoneNumber (text : String) -> Bool{
        if  text.count == 11 && text.isNumeric(){
            let prefix = String(text.prefix(3))
            if prefix == "010" || prefix == "011" || prefix == "012" ||  prefix == "015"  || prefix == "٠١٠" || prefix == "٠١١" || prefix == "٠١٢" || prefix == "٠١٥"
            {
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    static func doStringContainsNumber(text : String) -> Bool{
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: text)
        
        return containsNumber
    }
    
    static func isValidEmail(text : String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: text)
    }
    
    static func textHasOnlyNumbers(_ text: String) -> Bool {
        
        let charcterSet  = CharacterSet(charactersIn: "0123456789").inverted
        let inputString = text.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  text == filtered
    }
    
    static func isValidPassword(text: String)->Bool{
        return text.count >= 6
    }
}
