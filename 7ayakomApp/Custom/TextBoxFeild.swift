//
//  TextBoxFeild.swift
//  A3maly
//
//  Created by Nora Sayed on 10/9/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

protocol TextBoxDelegate {
    func textBoxDidChange(textBox : TextBoxFeild)
    func shouldChangeTextInRange(textBox : TextBoxFeild)
    func textBoxDidBeginEditing(textBox : TextBoxFeild)
    func textBoxDidEndEditing(textBox : TextBoxFeild)
    func textBoxShouldBeginEditing(textBox : TextBoxFeild)
    func textBoxShouldEndEditing(textBox : TextBoxFeild)
}

class TextBoxFeild: BaseNibLoader {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var field: UITextView!

    var actionHandler: ((Any)->Void)?
    var optional = false
    var customNonEmptyErrorMessage = ""
    var placeHolder = ""{
        didSet{
            refreshText()
        }
    }
    var placeHolderColor = UIColor.init(codeString: "#2B3862").withAlphaComponent(0.5){
        didSet{
            refreshText()
        }
    }
    var textColor = UIColor.init(codeString: "#2B3862").withAlphaComponent(0.7){
        didSet{
            refreshText()
        }
    }
    var delegate : TextBoxDelegate!

    
    
    @IBAction func buttonPressed(_ sender : Any){
        if actionHandler != nil{
            actionHandler!(sender)
        }
    }
    
    func reSet(){
        field.tag = 0
        self.refreshText()
        normal()
    }
    
    func refreshText(){
        if field.tag == 0 || field.text == "" || field.text == placeHolder {
            field.text =  placeHolder
            field.tag = 0
            field.textColor = placeHolderColor
        }else{
            field.textColor = textColor
            field.tag = 1
        }
    }
    
    override func awakeFromNib() {
        if appIsArabic(){
            field.textAlignment = .right
        }
        if errorLabel.text != "" || errorLabel.text != "Label" {
            customNonEmptyErrorMessage = errorLabel.text!
        }
        
        field.delegate = self
        self.normal()
    }
    
    func invalid(error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
        errorLabel.textColor = Colors.red
    }
    
    func normal() {
        self.refreshText()
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
    func getText() -> String {
        if field.tag == 0{
            return ""
        }else{
            return field.text!
        }
    }
    func setText(text: String){
        field.text = text
        if field.text.length == 0  {
            field.text =  placeHolder
            field.tag = 0
            field.textColor = placeHolderColor
            
        }else{
            field.textColor = textColor
            field.tag = 1
        }
    }
    
    func isEmptyAndNotOptional()->Bool{
        return self.getText().trim().isEmpty && !optional
    }
    
    func validate()->Bool{
        var isValid = true
        if isEmptyAndNotOptional(){
            isValid = false
            self.invalid(error: (customNonEmptyErrorMessage != "") ?
                customNonEmptyErrorMessage :
                "Feild can't be empty".localize())
        }
        return isValid
    }
}
extension TextBoxFeild : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if delegate != nil{
            delegate.textBoxDidChange(textBox: self)
        }
        if textView.text.length == 0  {
            textView.text =  placeHolder
            textView.tag = 0
            textView.textColor = placeHolderColor
            
        }else{
            textView.textColor = textColor
            textView.tag = 1
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if delegate != nil{
            delegate.shouldChangeTextInRange(textBox: self)
        }
        if textView.tag == 0 {
            textView.text = text
            textView.tag = 1
            return true
        }
        else{
            
            return true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if delegate != nil{
            delegate.textBoxDidBeginEditing(textBox: self)
        }
        if textView.tag == 0 {
            textView.text = ""
            textView.textColor = self.textColor
            textView.tag = 1
        }else{
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if delegate != nil{
            delegate.textBoxDidEndEditing(textBox: self)
        }
        if textView.tag == 1{
            if textView.text.trim() == ""
            {
                textView.text = self.placeHolder
                textView.textColor = self.placeHolderColor
                textView.tag = 0
            }
        }
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if delegate != nil{
            delegate.textBoxShouldBeginEditing(textBox: self)
        }
        return actionHandler == nil
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if delegate != nil{
            delegate.textBoxShouldEndEditing(textBox: self)
        }
        return true
    }

}
