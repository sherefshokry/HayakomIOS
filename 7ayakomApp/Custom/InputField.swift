//
//  inputField.swift
//  Shezlong
//
//  Created by George Naiem on 8/6/17.
//  Copyright © 2017 Bluecrunch. All rights reserved.
//

import UIKit

protocol InputFeildDelegate {
    func shouldBeginEditing(inputFeild : InputField)
    func didEndEditing(inputFeild : InputField)
    func didBeginEditing(inputFeild : InputField)
    func shouldReturn(inputFeild : InputField)
    func edittingChanged(inputFeild : InputField)
}

class InputField: BaseNibLoader  {
    
    public enum feildType : String{
        case email = "email"
        case password = "password"
        case phoneNumber = "phoneNumber"
        case number = "number"
        case regular = "regular"
    }
    
    var customNonEmptyErrorMessage = ""
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var field: UITextField!
    
    
    var actionHandler: ((Any)->Void)?
    var type : feildType = .regular
    var delegate : InputFeildDelegate!
    var optional = false
    var placeHolder = "" {
        didSet{
            field.placeholder = placeHolder
        }
    }
   
    
    @IBAction func buttonPressed(_ sender : Any){
        if actionHandler != nil{
            actionHandler!(sender)
        }
    }

   var textColor = Colors.textFeildFontColor

  
    func reSet(){
        setText(text: "")
        field.leftView = UIView()
        normal()
    }

    override func awakeFromNib() {
        if appIsArabic(){
            field.textAlignment = .right
        }
        if errorLabel.text != ""{
            customNonEmptyErrorMessage = errorLabel.text!
        }
       textColor = field.textColor!
        field.delegate = self
        self.field.addTarget(self, action: #selector(textFeildChanged), for: .editingChanged)
        field.setRightPaddingPoints(8)
        self.normal()
    }
    
    func invalid(error: String) {
        field.isEnabled = true
        errorLabel.text = error
        errorLabel.isHidden = false
        errorLabel.textColor = Colors.red

    }
 
    func dim() {
        field.isEnabled = false
    }
    
    func normal() {
        field.isEnabled = true
        field.textColor = textColor
        errorLabel.isHidden = true
        errorLabel.text = ""

    }
    
    func getText() -> String {
        return field.text!
    }
    func setText(text: String){
        field.text = text
    }
    
    func isEmptyAndNotOptional()->Bool{
        return self.getText().trim().isEmpty && !optional
    }
    
    
    func validate()->Bool{
        var isValid = true
        switch type {
        case .email:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "رجاء ادخل البريد الإلكترونى صحيح صحيح".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidEmail(text: self.getText().trim()){
                        isValid = false
                        self.invalid(error: "رجاء ادخل بريد الكترونى صحيح صحيح".localize())
                    }
                }
            }
            break
        case .password:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "Please enter password".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPassword(text: self.getText()) {
                        isValid = false
                        self.invalid(error: "Password should be more than 8 characters".localize())
                    }
                }
            }
            break
        case .phoneNumber:
            if  isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: "رجاء ادخل رقم الهاتف".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.isValidPhoneNumber(text: self.getText().trim()) {
                        isValid = false
                        self.invalid(error: "رجاء ادخل رقم هاتف صحيح".localize())
                    }
                }
            }
            break
        case .number:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: (customNonEmptyErrorMessage != "") ?
                    customNonEmptyErrorMessage :
                    "Feild can't be empty".localize())
            }else{
                if !optional || (optional && getText().trim() != ""){
                    if !Validations.textHasOnlyNumbers(self.getText().trim()) {
                        isValid = false
                        self.invalid(error: "من فضلك ادخل المدة بالدقائق".localize())
                    }
                }
            }
            break
        case .regular:
            if isEmptyAndNotOptional(){
                isValid = false
                self.invalid(error: (customNonEmptyErrorMessage != "") ?
                    customNonEmptyErrorMessage :
                    "Feild can't be empty".localize())
            }
            break
        }
        return isValid
    }
}

extension InputField : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if delegate != nil{
            delegate.didBeginEditing(inputFeild: self)
        }
        self.normal()
    }
    
    @objc func textFeildChanged(_ sender : UITextField){
        if delegate != nil{
            delegate.edittingChanged(inputFeild: self)
        }
        if type != .password{
            setText(text: getText().updateToEngNum())
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if delegate != nil{
            delegate.shouldBeginEditing(inputFeild: self)
        }
        self.normal()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if delegate != nil{
            delegate.shouldReturn(inputFeild: self)
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if delegate != nil{
            delegate.didEndEditing(inputFeild: self)
        }
        let _ = validate()
    }
}
