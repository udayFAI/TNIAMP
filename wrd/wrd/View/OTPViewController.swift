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
    
    var viewModel = OTPViewModel()
    var isStatusOTP = false
    var otp : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        otpTextField.delegate = self
        confirmButtonOutlet.corner(radius: 10.0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resendHandler(_ sender: Any) {
        showLoginVC()
    }
    
    
    @IBAction func confirmHandler(_ sender: Any) {
        guard let text = otpTextField.text, !text.isEmpty, isStatusOTP else {
            AlertHelper.showAlert(title: StaticString.alertTitle, message: "Please enter 4 digit OTP", viewController: self)
            return  }
//        guard GlobalData.shared.otp == Int(text) else {
//            AlertHelper.showAlert(title: StaticString.alertTitle, message: "Entered OTP is Invalid", viewController: self)
//            return
//        }
        // TODO: API Manager.phone=9629195152&otp=1591
        MRActivityIndicatorView.shared.show()
        let parameters: [String: String] = ["phone":GlobalData.shared.phone,
                                            "otp":text]
        viewModel.userOTPValidate(parameters)
       
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
        if let text = otpTextField.text?.trimmed(), viewModel.validate.numberValidation(text: text), let otp = Int(text), viewModel.validate.otpTextCount(text: text), Set(String(otp)).count != 1 {
            isStatusOTP = true
            PrintLog.success("OTP Success")
        } else if let age = otpTextField.text, age.count <= 0 {
            isStatusOTP = false
            PrintLog.error("OTP Failure")
        } else {
            isStatusOTP = false
            PrintLog.error("OTP Failure")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text?.trimmed() ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            PrintLog.error("OTP Failure")
        }
        return viewModel.validate.calculateTotalDigits(text: newText, maxLength: 4)
    }
}

extension OTPViewController: OTPValidatorDelegate {
    func failureOTP(status: Bool) {
        MRActivityIndicatorView.shared.hide()
        AlertHelper.showAlert(title: StaticString.alertTitle, message: "Try again after sometime", viewController: self)
    }
    func responseOTP(response: OTPValidate) {
        guard response.responseMessage?.result == nil else {
            AlertHelper.showAlert(title: StaticString.alertTitle, message: response.responseMessage?.result ?? "", viewController: self)
            return }
        GlobalData.shared.deptID = response.responseMessage?.lineDept ?? 0
        MRActivityIndicatorView.shared.hide()
        AppUserDefaults.SharedInstance.isStatusLoginOut = true
        showDashboardVC()
    }
}
