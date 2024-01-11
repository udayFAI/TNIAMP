//
//  ViewController.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 08/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var verifyButtonOutlet: UIButton!
    @IBOutlet weak var mobileTextField: DNMeterialTextField!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  print(WRD_Schema.root)
        mobileTextField.delegate = self
        verifyButtonOutlet.corner(radius: 10.0)
    }


    @IBAction func verifyHandler(_ sender: Any) {
        guard let text = mobileTextField.text, !text.isEmpty, viewModel.isMobileStatus() else {
            AlertHelper.showAlert(title: StaticString.alertTitle, message: "Please enter phone number", viewController: self)
            return  }
        // TODO: API Manager.
        showOTPVC()
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = mobileTextField.text, viewModel.validate.numberValidation(text: text), viewModel.validate.mobileNumberCount(text: text), viewModel.validate.isValidMobileNumber(text: text) {
            viewModel.mobileStatus = true
            PrintLog.success("Success")
        } else if let age = mobileTextField.text, age.count <= 0 {
            viewModel.mobileStatus = false
            PrintLog.error("Failure")
        } else {
            viewModel.mobileStatus = false
            PrintLog.error("Failure")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text?.trimmed() ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            PrintLog.error("Failure")
        }
        return viewModel.textFieldCharactersValidate(text: newText)
    }
}
