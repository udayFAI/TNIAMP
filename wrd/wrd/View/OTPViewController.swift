//
//  OTPViewController.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var otpTextField: DNMeterialTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpTextField.delegate = self
        confirmButtonOutlet.corner(radius: 10.0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resendHandler(_ sender: Any) {
        AlertHelper.showAlert(title: StaticString.alertTitle, message: "New 4 digit OTP has been sent to your 8465969964 mobile number", viewController: self)
    }
    
    
    @IBAction func confirmHandler(_ sender: Any) {
        guard let text = otpTextField.text, !text.isEmpty else {
            AlertHelper.showAlert(title: StaticString.alertTitle, message: "Please enter 4 digit OTP", viewController: self)
            return  }
        // TODO: API Manager.
        showDashboardVC()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension OTPViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let text = otpTextField.text, viewModel.validate.numberValidation(text: text), viewModel.validate.mobileNumberCount(text: text), viewModel.validate.isValidMobileNumber(text: text) {
//            PrintLog.success("Success")
//        } else if let age = mobileTextField.text, age.count <= 0 {
//            PrintLog.error("Failure")
//        } else {
//            PrintLog.error("Failure")
//        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            PrintLog.error("Failure")
        }
        return true // viewModel.textFieldCharactersValidate(text: newText)
    }
}
